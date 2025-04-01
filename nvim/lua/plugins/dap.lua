return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'theHamsta/nvim-dap-virtual-text',
      },
    },
    opts = function()
      local php_dap = '/home/bjaskulski/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js'
      return {
        adapters = {
          php = {
            type = 'executable',
            command = 'node',
            args = { php_dap }
          },
          firefox = {
            type = 'executable',
            command = 'node',
            args = { os.getenv('HOME') .. '/github.com/firefox-devtools/vscode-firefox-debug/dist/adapter.bundle.js' },
          }
        },
        configurations = {
          typescript = {
            {
              name = 'Debug with Firefox',
              type = 'firefox',
              request = 'launch',
              reAttach = true,
              url = 'http://localhost:3000',
              webRoot = '${workspaceFolder}',
              firefoxExecutable = '/usr/bin/firefox'
            }
          },
          php = {
            {
              type = 'php',
              request = 'launch',
              name = 'Listen for Xdebug',
              port = 9003,
              pathMappings = {
                ['/var/www/html'] = "/home/bjaskulski/Templates/WordPress",
                ['/var/www/html/wp-content/plugins/woocommerce'] = "/home/bjaskulski/Plugins/woocommerce",
                ['/var/www/html/wp-content/plugins/flexible-subscriptions'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-subscriptions",
                ['/var/www/html/wp-content/plugins/flexible-subscriptions-recurring-shipping'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-subscriptions-recurring-shipping",
                ['/var/www/html/wp-content/plugins/flexible-subscriptions-stock-management'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-subscriptions-stock-management",
                ['/var/www/html/wp-content/plugins/flexible-subscriptions-payment-retry'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-subscriptions-payment-retry",
                -- ['/var/www/html/wp-content/plugins/flexible-wishlist'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-wishlist",
                ['/var/www/html/wp-content/plugins/flexible-wishlist-analytics'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-wishlist-analytics",
                ['/var/www/html/wp-content/plugins/ean'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/ean/wp-content/plugins/ean",
                ['/var/www/html/wp-content/plugins/shopmagic-for-woocommerce'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-for-woocommerce",
                ['/var/www/html/wp-content/plugins/shopmagic-abandoned-carts'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-abandoned-carts",
                ['/var/www/html/wp-content/plugins/shopmagic-customer-coupons'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-customer-coupons",
                ['/var/www/html/wp-content/plugins/shopmagic-manual-actions'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-manual-actions",
                ['/var/www/html/wp-content/plugins/shopmagic-woocommerce-bookings'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-woocommerce-bookings",
                ['/var/www/html/wp-content/plugins/shopmagic-advanced-filters'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-advanced-filters",
                ['/var/www/html/wp-content/plugins/shopmagic-webhooks'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-webhooks",
                ['/var/www/html/wp-content/plugins/woocommerce-bookings'] =
                "/home/bjaskulski/Plugins/woocommerce-bookings",
                ['/var/www/html/wp-content/plugins/woocommerce-subscriptions'] =
                "/home/bjaskulski/Plugins/woocommerce-subscriptions",
                ['/var/www/html/wp-content/plugins/woocommerce-gateway-stripe'] =
                "/home/bjaskulski/Plugins/woocommerce-gateway-stripe",
                ['/var/www/html/wp-content/plugins/wp-desk-omnibus'] =
                "/home/bjaskulski/Repos/gitlab.wpdesk.dev/wp-desk-omnibus",
                ['/var/www/html/wp-content/plugins/flexible-refund-and-return-order-for-woocommerce'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-refund-and-return-order-for-woocommerce",
                ['/var/www/html/wp-content/plugins/shopmagic-for-twilio'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-for-twilio-wp-init",
                ['/var/www/html/wp-content/plugins/shopmagic-for-google-sheets'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-for-google-sheets",
                ['/var/www/html/wp-content/plugins/flexible-wishlist'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-wishlist",
                ['/var/www/html/wp-content/plugins/woocommerce-gateway-payu-pl'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/woocommerce-gateway-payu-pl",
                ['/var/www/html/wp-content/plugins/woocommerce-wfirma'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/woocommerce-wfirma",
                ['/var/www/html/wp-content/plugins/flexible-checkout-fields'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-checkout-fields",
                ['/var/www/html/wp-content/plugins/paczka'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/woocommerce-paczka-w-ruchu",
                ['/var/www/html/wp-content/plugins/flexible-invoices-woocommerce'] = "/home/bjaskulski/Repos/full-gitlab/wpdesk/heroes/flexible-invoices-woocommerce",
                ['/var/www/html/wp-content/plugins/woocommerce-gateway-przelewy24'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/woocommerce-gateway-przelewy24",
                ['/var/www/html/wp-content/plugins/woocommerce-flexible-pricing'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/woocommerce-flexible-pricing",
              },
              stopOnEntry = false,
              log = false
            }
          }
        }
      }
    end,
    config = function(_, opts)
      vim.api.nvim_set_hl(0, 'DebugBreakpoint', { bg = '#e4b7be' })
      vim.api.nvim_set_hl(0, 'debugPC', { default = true, link = 'Visual' })

      vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'ErrorMsg', linehl = 'DebugBreakpoint', numhl = '' })

      local dap = require('dap')
      for name, adapter in pairs(opts.adapters) do
        dap.adapters[name] = adapter
      end

      for lang, config in pairs(opts.configurations) do
        dap.configurations[lang] = config
      end
    end,
    keys = {
      { "<leader>gc", function() require("dap").continue() end,           desc = "Run/Continue" },
      { "<leader>gn", function() require("dap").step_over() end,          desc = "Step Over" },
      { "<leader>gi", function() require("dap").step_into() end,          desc = "Step Into" },
      { "<leader>go", function() require("dap").step_out() end,           desc = "Step Out" },
      { "<leader>gb", function() require("dap").toggle_breakpoint() end,  desc = "Toggle Breakpoint" },
      { "<leader>gt", function() require("dap").terminate() end,          desc = "Terminate" },
      { "<leader>gC", function() require("dap").run_to_cursor() end,      desc = "Run to Cursor" },
      { '<Leader>dh', function() require('dap.ui.widgets').hover() end,   mode = { 'n', 'v' }, },
      { '<Leader>dp', function() require('dap.ui.widgets').preview() end, mode = { 'n', 'v' }, },
      { '<Leader>dr', function() require('dap').repl.open() end },
      { '<Leader>df', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end },
      { '<Leader>ds', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end },
    }
  },
}
