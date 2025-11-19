return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = 'v1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {},
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        -- hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = "<Tab>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
    },
  },
}
