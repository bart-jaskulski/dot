return {
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    opts = {
        options = {
          -- ["styles.comments"] = 'italic',
          transparent = true,
          dim_inactive = true
        }
    },
    init = function()
      vim.cmd('colorscheme github_light')
    end
  },
}
