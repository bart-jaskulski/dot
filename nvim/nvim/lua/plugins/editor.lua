local function edit_or_open()
  local api = require "nvim-tree.api"
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file
    api.node.open.edit()
    -- Close the tree if file was opened
    api.tree.close()
  end
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'l', edit_or_open, opts('Edit or Open'))
  vim.keymap.set('n', 'h', api.tree.collapse_all, opts('Close'))
end

return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    opts = {
      on_attach = my_on_attach,
      sort_by = "case_sensitive",
      view = { width = 25, },
      renderer = { group_empty = true, },
      filters = { dotfiles = true, },
      sync_root_with_cwd = true,
      hijack_cursor = true,
      actions = {
        change_dir = {
          restrict_above_cwd = true
        }
      }
    },
  },
  {
    'echasnovski/mini.pick',
    dependencies = {
      'echasnovski/mini.extra',
      opts = {}
    },
    cmd = "Pick",
    opts = function()
      return {
        -- Keys for performing actions. See `:h MiniPick-actions`.
        mappings = {
          choose            = '<CR>',
          choose_in_split   = '<M-s>',
          choose_in_tabpage = '<M-t>',
          choose_in_vsplit  = '<M-v>',
          choose_marked     = '<M-CR>',

          mark              = '<M-Space>',
          mark_all          = '<M-a>',

          paste             = '<C-r>',

          refine            = '<C-Space>',
          refine_marked     = '',

          scroll_down       = '<C-f>',
          scroll_left       = '<C-h>',
          scroll_right      = '<C-l>',
          scroll_up         = '<C-b>',

          stop              = '<Esc>',

          toggle_info       = '<S-Tab>',
          toggle_preview    = '<Tab>',
        },

        -- General options
        options = {
          -- Whether to show content from bottom to top
          content_from_bottom = false,

          -- Whether to cache matches (more speed and memory on repeated prompts)
          use_cache = true,
        },

        -- Source definition. See `:h MiniPick-source`.
        source = {
          items         = nil,
          name          = nil,
          cwd           = nil,

          match         = nil,
          show          = nil,
          preview       = nil,

          choose        = nil,
          choose_marked = nil,
        },

        window = {
          config = function()
            local height = math.floor(0.618 * vim.o.lines)
            local width = math.floor(0.618 * vim.o.columns)
            return {
              anchor = 'NW',
              height = height,
              width = width,
              row = math.floor(0.5 * (vim.o.lines - height)),
              col = math.floor(0.5 * (vim.o.columns - width)),
            }
          end,
        }
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          vim.ui.select = function(...)
            require("lazy").load({ plugins = { "mini.pick" } })
            return MiniPick.ui_select(...)
          end
        end,
      })
    end,
    keys = {
      { '<leader>f', '<cmd>Pick files<cr>',                       desc = 'Open file picker' },
      {
        '<leader>F',
        function()
          MiniPick.builtin.files({}, { source = { cwd = vim.fn.expand("%:p:h") } })
        end,
        desc = 'Open file picker at current working directory',
      },
      { '<leader>b', '<cmd>Pick buffers<cr>',                     desc = 'Open buffer picker',                          silent = true },
      { '<leader>/', '<cmd>Pick grep_live<cr>',                   desc = 'Global search in workspace folder' },
      { '<leader>q', '<cmd>Pick list scope="quickfix"<cr>',       desc = 'Open quickfix list picker' },
      { '<leader>l', '<cmd>Pick list scope="location"<cr>',       desc = 'Open location list picker' },
      { '<leader>*', '<cmd>Pick grep pattern="<cword>"<cr>',      desc = 'Global search for a word in workspace folder' },
      { 'gO',        '<cmd>Pick lsp scope="document_symbol"<cr>', desc = 'Open symbol picker' },
      { 'grr',       '<cmd>Pick lsp scope="references"<cr>',      desc = 'Open symbol picker' },
      { 'gri',       '<cmd>Pick lsp scope="implementation"<cr>',  desc = 'Open symbol picker' },
      { '<leader>d', '<cmd>Pick diagnostic<cr>',                  desc = 'Open diagnostic picker' },
      -- { "<leader>'", '<cmd>FzfLua<cr>',                                            desc = 'Open picker' },
      { "q:",        '<cmd>Pick history scope=":"<cr>',           desc = 'Vim command history' },
      { "q/",        '<cmd>Pick history scope="/"<cr>',           desc = 'Vim command history' },
      { "z=",        "<cmd>Pick spellsuggest<cr>",                desc = 'Spell suggest' },
    }
  },
  {
    'echasnovski/mini.diff',
    event = "VeryLazy",
    opts = {
      view = {
        style = 'sign',
        signs = {
          add    = '┃',
          delete = '–',
          change = '~',
        }
      },
    },
  },
  {
    'echasnovski/mini.jump',
    opts = {},
    keys = { 'f', 'F', 't', 'T' }
  },
  {
    'aserowy/tmux.nvim',
    opts = {
      copy_sync = {
        enable = false
      },
      resize = {
        enable_default_keybindings = false
      }
    },
    keys = { '<c-l>', '<c-h>', '<c-k>', '<c-j>' }
  }
}
