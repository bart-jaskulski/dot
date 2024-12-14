--- Mimic 0.11 defaults
-- Quickfix list mappings
vim.keymap.set("n", "[q", ":cprevious<CR>", { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { desc = "First quickfix" })
vim.keymap.set("n", "]Q", ":clast<CR>", { desc = "Last quickfix" })
-- Location list mappings
vim.keymap.set("n", "[l", ":lprevious<CR>", { desc = "Previous location" })
vim.keymap.set("n", "]l", ":lnext<CR>", { desc = "Next location" })
vim.keymap.set("n", "[L", ":lfirst<CR>", { desc = "First location" })
vim.keymap.set("n", "]L", ":llast<CR>", { desc = "Last location" })
-- buffer navigation
vim.keymap.set('n', 'ga', '<cmd>:b#<cr>', { desc = 'Go to alternate file' })
vim.keymap.set('n', '[b', '<cmd>:bn<cr>', { desc = 'Go to next buffer' })
vim.keymap.set('n', ']b', '<cmd>:bp<cr>', { desc = 'Go to previous buffer' })

local user_lsp_group = vim.api.nvim_create_augroup('UserLspConfig', {})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = user_lsp_group,
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)

    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  end,
})

vim.keymap.set('n', '<leader><TAB>', function()
  require 'nvim-tree.api'.tree.toggle()
end, { desc = 'Toggle file explorer' })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { silent = true, desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { silent = true, desc = "Move up" })
vim.keymap.set("n", "<A-h>", "<<", { silent = true, desc = "Move left" })
vim.keymap.set("n", "<A-l>", ">>", { silent = true, desc = "Move right" })
-- vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })


-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set('n', '<leader>x', '<cmd>q<cr>', { desc = 'Close buffer' })

-- vim.keymap.set('i', '<Tab>', function ()
--   return vim.fn.pumvisible() == 1 and '<C-y>' or vim.cmd('call codeium#Accept()')
-- end, { desc = 'Insert completion', expr = true, silent = true })

-- Keep matches center screen when cycling with n|N
vim.keymap.set("n", "n", "nzzzv", { desc = "Fwd  search '/' or '?'" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Back search '/' or '?'" })

vim.cmd([[inoremap <script><silent><nowait><expr> <Tab> pumvisible() ? "\<C-y>" : codeium#Accept()]])
