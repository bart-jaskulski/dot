return {
  {
    "olimorris/codecompanion.nvim",
    cmd = {"CodeCompanion","CodeCompanionActions","CodeCompanionChat"},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic_haiku",
        },
        agent = {
          adapter = "anthropic",
        },
      },
      display = {
        diff = {
          provider = "mini_diff"
        }
      },
      adapters = {
        anthropic_haiku = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = {
              model = {
                default = "claude-3-5-haiku-20241022",
              },
            },
          })
        end,
      },
    }
  },
}
