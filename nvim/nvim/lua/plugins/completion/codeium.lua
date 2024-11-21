return {
  {
    'Exafunction/codeium.nvim',
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        -- key_bindings = {
        --   -- accept = true, -- handled by nvim-cmp / blink.cmp
        --   next = "<M-]>",
        --   prev = "<M-[>",
        -- },
      },
    },
  },
}
