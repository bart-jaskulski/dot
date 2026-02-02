return {
  {
    "nvim-mini/mini.statusline",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    opts = {
      content = {
        active = function()
          local filenameFunc = function ()
            -- In terminal always use plain name
            if vim.bo.buftype == 'terminal' or vim.bo.buftype == 'quickfix' then
              return '%t'
            end

            local filename = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
            if filename:len() > 50 then filename = vim.fn.pathshorten(filename) end
            if filename:len() > 50 then filename = '%t' end

            return string.format('%s%s', filename, '%m%r') -- 'modified', 'readonly' flags
          end

          local mode, mode_hl = MiniStatusline.section_mode({trunc_width = 1000})
          local filename      = filenameFunc()
          local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl,                  strings = { mode } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFileinfo', strings = { search } },
          })
        end,

        inactive = function()
          return '%#MiniStatuslineInactive#%=%f%='
        end
      }
    },
  },
  {
    "nvim-mini/mini.indentscope",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = function()
      return {
        draw = {
          animation = require("mini.indentscope").gen_animation.none(),
        },
        -- symbol = "│",
        options = { try_as_border = true },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        callback = function()
          vim.cmd([[hi MiniIndentscopeSymbol guifg=#CCCDCD]])
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "Trouble",
          "alpha",
          "dashboard",
          "help",
          "lazy",
          "mason",
          "neo-tree",
          "notify",
          "snacks_notif",
          "snacks_terminal",
          "snacks_win",
          "toggleterm",
          "trouble",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    'nvim-mini/mini.hipatterns',
    event = "VeryLazy",
    opts = function()
      local hi = require("mini.hipatterns")

      -- 1. Define the Math: OKLCH -> sRGB -> Hex Conversion
      -- This is necessary because Neovim highlight groups require Hex values.
      local function oklch_to_hex(match)
        -- Extract values from syntax: oklch(L C H / A)
        -- Supports: oklch(0.6 0.1 180) and oklch(60% 0.1 180)
        local l_str, c_str, h_str = match:match("oklch%s*%(%s*([%d%.%%]+)%s+([%d%.]+)%s+([%d%.]+)")

        if not l_str or not c_str or not h_str then return nil end

        local L = tonumber(l_str:match("[%d%.]+"))
        if l_str:find("%%") then L = L / 100 end
        local C = tonumber(c_str)
        local h = tonumber(h_str)

        -- Convert OKLCH (Polar) -> OKLab (Cartesian)
        local h_rad = h * (math.pi / 180)
        local a = C * math.cos(h_rad)
        local b = C * math.sin(h_rad)

        -- Convert OKLab -> Linear sRGB
        -- Matrix references: https://bottosson.github.io/posts/oklab/
        local l_ = L + 0.3963377774 * a + 0.2158037573 * b
        local m_ = L - 0.1055613458 * a - 0.0638541728 * b
        local s_ = L - 0.0894841775 * a - 1.2914855480 * b

        local l_3 = l_ * l_ * l_
        local m_3 = m_ * m_ * m_
        local s_3 = s_ * s_ * s_

        local r_lin = 4.0767416621 * l_3 - 3.3077115913 * m_3 + 0.2309699292 * s_3
        local g_lin = -1.2684380046 * l_3 + 2.6097574011 * m_3 - 0.3413193965 * s_3
        local b_lin = -0.0041960863 * l_3 - 0.7034186147 * m_3 + 1.7076147010 * s_3

        -- Gamma Correction (Linear sRGB -> sRGB)
        local function gamma(x)
          if x >= 0.0031308 then
            return 1.055 * math.pow(x, 1.0 / 2.4) - 0.055
          else
            return 12.92 * x
          end
        end

        local r = math.floor(math.max(0, math.min(1, gamma(r_lin))) * 255 + 0.5)
        local g = math.floor(math.max(0, math.min(1, gamma(g_lin))) * 255 + 0.5)
        local bl = math.floor(math.max(0, math.min(1, gamma(b_lin))) * 255 + 0.5)

        return string.format("#%02x%02x%02x", r, g, bl)
      end

      return {
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color(),
          -- oklch_color = {
          --   -- Regex to match: oklch( ... )
          --   pattern = 'oklch%s*%(.-%)', 
          --
          --   -- Function to determine the highlight group
          --   group = function(_, match)
          --     local hex = oklch_to_hex(match)
          --     if hex then
          --       -- Create/get a highlight group for this specific hex color
          --       return hi.compute_hex_color_group(hex, 'bg')
          --     end
          --   end,
          -- },
        },
      }
    end,
    dependencies = { 'nvim-mini/mini.colors' }
  },
}
