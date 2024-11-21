return {
  {
    'saghen/blink.cmp',
    enabled = false,
    event = "InsertEnter",
    version = '*',
    opts = {
      keymap = { preset = 'default' },
      windows = {
        autocomplete = {
          winblend = vim.o.pumblend,
        },
        documentation = {
          auto_show = true,
        },
        ghost_text = {
          enabled = true,
        },
      },

      highlight = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',

      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = true } },

      -- experimental signature help support
      trigger = { signature_help = { enabled = true } },
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        completion = {
          -- remember to enable your providers here
          enabled_providers = { "lsp", "path", "snippets" },
        },
        providers = {}
      },
    },
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
    },
    ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
    config = function(_, opts)
      -- setup compat sources
      local enabled = opts.sources.completion.enabled_providers
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end
      require("blink.cmp").setup(opts)
    end,
  },

}
