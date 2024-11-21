return {
  {
    'ms-jpq/coq_nvim',
    -- enabled = false,
    event = "InsertEnter",
    branch = 'coq',
    build = ':COQdeps',
    init = function()
      vim.g.coq_settings = {
        auto_start = 'shut-up',
        keymap = {
          recommended = false,
          jump_to_mark = "<M-space>",
        },
        clients = {
          lsp = { enabled = true },
          tree_sitter = { enabled = false },
          tags = { enabled = false },
          buffers = { enabled = false },
          tmux = { enabled = false },
          snippets = { enabled = false },
          registers = { enabled = false },
        }
      }
    end,
  }
}
