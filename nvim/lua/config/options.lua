vim.g.mapleader = ' '

-- set nobackup
-- set noswapfile
-- set nowritebackup
-- vim.opt.directory='~/.vimswap'
vim.opt.autoindent = true
vim.opt.autoread = true -- automatically read a file if changed outside
vim.opt.autowrite = true -- automatically write files when changing when multiple files open
vim.opt.clipboard='unnamedplus'
vim.opt.cmdheight = 1
vim.opt.colorcolumn='80'
vim.opt.complete:remove { 't' ,'i' }
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect', 'fuzzy' }
vim.opt.cursorline = true
vim.opt.display='lastline'
vim.opt.expandtab = true
vim.opt.fixendofline = false -- stop vim from silently messing with files that it shouldn't
vim.opt.foldexpr='nvim_treesitter#foldexpr()'
vim.opt.foldlevel=999
vim.opt.foldmethod='expr'
vim.opt.foldminlines=5
vim.opt.foldnestmax=2
vim.opt.formatoptions='cq1lmMjp'
vim.opt.hidden = true -- stop complaints about switching buffer with changes
vim.opt.history = 10000
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2 -- Display status line only for the last window
vim.opt.lazyredraw = true -- don't redraw while executing macros
vim.opt.linebreak = true
vim.opt.mouse='a'
vim.opt.number = true
vim.opt.path:prepend { 'src/**', 'assets/**' }
vim.opt.pumblend=10
vim.opt.pumheight=10
vim.opt.relativenumber = true
vim.opt.scrolloff=8
vim.opt.sessionoptions:remove { 'blank', 'buffers', 'folds', 'help', 'terminal' }
vim.opt.shiftwidth = 2
vim.opt.shortmess = {
  a = true, -- use abbreviation
  o = true, -- use abbreviation
  O = true, -- use abbreviation
  s = true, S = true, -- search info is on statusline
  t = true, -- truncate messages
  T = true, -- truncate messages
  I = true, -- hide info page
  W = true, -- don't care about written
  F = true, -- don't care file info
}
vim.opt.showmode = true -- Show command and insert mode
vim.opt.showtabline = 1 -- Show tab line only if there are 2+ tabs
vim.opt.sidescrolloff=3
vim.opt.signcolumn = "yes" -- Display any signs over numbers
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
-- vim.opt.spell = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.textwidth=100
vim.opt.ttimeout = true
vim.opt.ttimeoutlen=100
vim.opt.ttyfast = true -- faster scrolling
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.wildmenu = true -- better command-line completion
vim.opt.wildmode='longest:full'
vim.opt.winblend=10
vim.opt.wrapscan = true -- wrap around when searching

if os.getenv('DISPLAY') ~= nil then
  vim.opt.termguicolors = true
  vim.opt.background = 'light'
  -- better ascii friendly listchars
  vim.opt.listchars = {
    lead = '*', trail = '*', tab = '|>',
    extends = '…', precedes = '…', nbsp = '␣'
  }
  vim.opt.list = true -- display hidden chars only in TTY
else
  vim.opt.background = 'dark'
  vim.opt.cursorline = false
end

-- Use ripgrep for searching
if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg='rg --vimgrep --no-heading --smart-case'
end

vim.fn.matchadd('IncSearch', [[\s\+$]]); -- mark trailing spaces as errors

-- Disable unnecessary providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Improve netrw
vim.g.netrw_keepdir = 1
vim.g.netrw_winsize = 20
vim.g.netrw_banner = 0
-- vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+' .. vim.fn.netrw_gitignore.Hide()
vim.g.netrw_hide = 1
vim.g.netrw_localcopydircmdopt = ' -Rr'
vim.g.netrw_localmkdiropt = ' -p'
vim.g.netrw_localrmdiropt = ' -p'

-- Tree display
vim.g.netrw_liststyle = 3
vim.g.netrw_sizestyle = "H"

-- Highlight link
vim.cmd('hi! link netrwMarkFile Search')

