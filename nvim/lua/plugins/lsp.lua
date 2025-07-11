return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "",
              [vim.diagnostic.severity.WARN] = "",
              [vim.diagnostic.severity.HINT] = "",
              [vim.diagnostic.severity.INFO] = "",
            },
            numhl = {
              [vim.diagnostic.severity.ERROR] = "ErrorMsg",
              [vim.diagnostic.severity.WARN] = "WarningMsg",
              [vim.diagnostic.severity.HINT] = "DiagnosticHint",
              [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            },
          },
        },
        inlay_hints = {
          enabled = true,
          exclude = { "vue" },
        },
        codelens = {
          enabled = false,
        },
        document_highlight = {
          enabled = true,
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  checkThirdParty = false,
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          },
          phpactor = {
            -- cmd = { "/home/bjaskulski/Repos/github.com/phpactor/phpactor/build/phpactor.phar", "language-server" },
          },
          gopls = {
            settings = {
              gopls = {
                hints = { parameterNames = true }
              }
            }
          }
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- setup autoformat
      -- LazyVim.format.register(LazyVim.lsp.formatter())

      -- setup keymaps
      -- LazyVim.lsp.on_attach(function(client, buffer)
      --   require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      -- end)

      -- LazyVim.lsp.setup()
      -- LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)

      --   -- inlay hints
      --   if opts.inlay_hints.enabled then
      --     LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
      --       if
      --         vim.api.nvim_buf_is_valid(buffer)
      --         and vim.bo[buffer].buftype == ""
      --         and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
      --       then
      --         vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
      --       end
      --     end)
      --   end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      -- local has_blink, blink = pcall(require, "blink.cmp")
      local has_coq, coq = pcall(require, "coq")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        -- has_blink and blink.get_lsp_capabilities() or {},
        has_coq and coq.lsp_ensure_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig").get_mappings().lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup({
          -- ensure_installed = ensure_installed,
          -- LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
          handlers = { setup },
        })
      end
    end,
  },

  -- cmdline tools and lsp servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    -- version = "1.10.0",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    -- opts_extend = { "ensure_installed" },
    opts = true
    -- opts = {
    --   ensure_installed = {},
    -- }
  },
}
