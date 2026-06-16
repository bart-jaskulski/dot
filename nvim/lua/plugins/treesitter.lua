return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    -- event = "VeryLazy",
    opts = {
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
          },
        },
      }
    },
    -- config = function(_, opts)
    --   require 'nvim-treesitter'.setup(opts)
    -- end,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = "VeryLazy",
      },
      {
        'nvim-treesitter/nvim-treesitter-context',
        event = "VeryLazy",
        opts = {
          mode = "cursor",
          max_lines = 3,
        },
      }
    }
  },
}
