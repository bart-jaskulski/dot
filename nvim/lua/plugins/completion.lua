return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = 'v1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {},
    -- opts = {
    --   -- 'default' for mappings similar to built-in completion
    --   -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    --   -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    --   -- See the full "keymap" documentation for information on defining your own keymap.
    --   keymap = { preset = 'default' },
    --
    --   appearance = {
    --     -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    --     -- Useful for when your theme doesn't support blink.cmp
    --     -- Will be removed in a future release
    --     use_nvim_cmp_as_default = true,
    --     -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    --     -- Adjusts spacing to ensure icons are aligned
    --     nerd_font_variant = 'mono'
    --   },
    --
    --   -- Default list of enabled providers defined so that you can extend it
    --   -- elsewhere in your config, without redefining it, due to `opts_extend`
    --   sources = {
    --     default = { 'lsp', 'path', 'snippets', 'buffer' }
    --   },
    -- },
    -- opts_extend = { "sources.default" }
  },
  {
    "supermaven-inc/supermaven-nvim",
    opts = true,
    event = "InsertEnter",
  }
}
