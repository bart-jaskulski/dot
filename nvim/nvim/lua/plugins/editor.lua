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
    'ibhagwan/fzf-lua',
    -- dependencies = 'echasnovski/mini.icons',
    cmd = 'FzfLua',
    opts = {
      defaults = {
        formatter = "path.filename_first",
        -- formatter = "path.dirname_first",
        preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
      },
      keymap = {
        fzf = {
          ["alt-space"] = "toggle",
          ["alt-a"] = "toggle-all",
        }
      },
      actions = {
        quickfix = {
          ["default"] = function(selected, opts)
            if #selected == 1 then
              vim.inspect(selected)
              vim.inspect(opts)
            end
            return require("fzf-lua.actions").file_edit_or_qf(selected, opts)
          end
        },
      },
      buffers = { cwd_only = true, },
      oldfiles = {
        cwd_only = true,
        include_current_session = true
      },
      grep = {
        multiline = 1,
        rg_glob = true,
      },
      files = {
        cwd_prompt = false,
      },
      builtin = {
        treesitter = {
          disabled = { "xdefaults" }
        }
      },
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { "┃", "" },
        },
      },
    },
    keys = {
      { '<leader>f', function() require('fzf-lua').files() end,                    desc = 'Open file picker',                              silent = true },
      { '<leader>F', function() require('fzf-lua').files({ cwd = "%:p:h" }) end,   desc = 'Open file picker at current working directory', silent = true },
      { '<leader>b', function() require('fzf-lua').buffers() end,                  desc = 'Open buffer picker',                            silent = true },
      { '<leader>/', function() require('fzf-lua').live_grep() end,                desc = 'Global search in workspace folder' },
      { '<leader>q', function() require('fzf-lua').quickfix() end,                 desc = 'Open quickfix list picker' },
      { '<leader>l', function() require('fzf-lua').loclist() end,                  desc = 'Open location list picker' },
      { '<leader>*', function() require('fzf-lua').grep_cword() end,               desc = 'Global search for a word in workspace folder' },
      { 'gO', function() require('fzf-lua').lsp_document_symbols() end,     desc = 'Open symbol picker' },
      { 'grr', function() require('fzf-lua').lsp_references() end,     desc = 'Open LSP references picker' },
      { 'gri', function() require('fzf-lua').lsp_implementations() end,     desc = 'Open LSP implementations picker' },
      { '<leader>d', function() require('fzf-lua').lsp_document_diagnostics() end, desc = 'Open diagnostic picker' },
      { "<leader>'", '<cmd>FzfLua<cr>',                                            desc = 'Open picker' },
      { "q:",        function() require('fzf-lua').command_history() end,          desc = 'Vim command history' },
      { "q/",        function() require('fzf-lua').search_history() end,           desc = 'Open picker' },
      { "z=",        function() require('fzf-lua').spell_suggest() end,            desc = 'Spell suggest' },
    },
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
    event = "VeryLazy",
  },
  {
    'aserowy/tmux.nvim',
    event = "VeryLazy",
    opts = {
      copy_sync = {
        enable = false
      },
      resize = {
        enable_default_keybindings = false
      }
    },
  }
}
