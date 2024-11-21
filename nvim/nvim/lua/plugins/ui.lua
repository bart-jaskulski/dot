return {
  {
    "echasnovski/mini.statusline",
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
          local location      = '%l:%v (%p%%)'
          local filename      = filenameFunc()
          local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl,                  strings = { mode } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFileinfo', strings = { search } },
            { hl = mode_hl,                  strings = { location } },
          })
        end,

        inactive = function()
          return '%#MiniStatuslineInactive#%=%f%='
        end
      }
    },
  },
}
