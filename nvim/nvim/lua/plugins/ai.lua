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
          adapter = "anthropic",
        },
        agent = {
          adapter = "anthropic",
        },
      },
      display = {
        diff = {
          provider = "mini_diff"
        }
      }
    }
  },
}
