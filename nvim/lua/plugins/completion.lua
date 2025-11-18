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
    "supermaven-inc/supermaven-nvim",
    opts = true,
    event = "InsertEnter",
    enabled = false,
  },
  {
    "milanglacier/minuet-ai.nvim",
    enabled = true,
    main = "minuet",
    opts = {
      virtualtext = {
        auto_trigger_ft = { '*' },
        auto_trigger_ignore_ft = { 'markdown', 'gitcommit' },
        keymap = {
          -- accept whole completion
          accept = '<Tab>',
          -- accept one line
          accept_line = nil,
          -- accept n lines (prompts for number)
          -- e.g. "A-z 2 CR" will accept 2 lines
          accept_n_lines = nil,
          -- Cycle to prev completion item, or manually invoke completion
          prev = nil,
          -- Cycle to next completion item, or manually invoke completion
          next = nil,
          dismiss = '<A-e>',
        },
      },
      debounce = 250,
      add_single_line_entry = false,
      -- If one response is not good, neither will
      n_completions = 1,
      provider = "openai_fim_compatible",
      provider_options = {
        openai_fim_compatible = {
          model = "mercury-coder",
          end_point = "https://api.inceptionlabs.ai/v1/fim/completions",
          api_key = 'MERCURY_API_KEY',
          name = "Mercury Coder",
          stream = true,
          optional = {
            max_tokens = 5000,
          }
        }
      }
    },
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  }
}
