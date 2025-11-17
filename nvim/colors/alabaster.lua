-- Neovim Colorscheme
-- Name: Alabaster BG
-- Author: Nikita Prokopov (Converted & Tuned by Gemini)

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'alabaster_bg'
vim.opt.background = 'light'

-- Color Palette
local p = {
  active     = '#007ACC',
  fg         = '#000000',
  bg         = '#FFFFFF',
  
  -- Background Colors (for highlighted elements)
  blue       = '#DBF1FF',  -- light blue for top-level defs
  green      = '#F1FADF',  -- light green for strings
  dark_green = '#DBECB6',  -- darker green for strings
  red        = '#FFE0E0',
  magenta    = '#F9E0FF',  -- purple for constants
  yellow     = '#fffde0',  -- yellow for comments
  orange     = '#FFBC5D',

  -- Foreground Colors for pairing
  blue_fg    = '#005A9C',  -- light blue (defs)
  green_fg   = '#2F7A2F',  -- strings and numbers
  magenta_fg = '#7A3E9D',  -- constants
  yellow_fg  = '#c79f00',  -- comments

  -- UI Colors
  inactive   = '#E0E0E0',
  selection  = '#B4D8FD',
  faint_fg   = '#888888',  -- faint colors for less important elements
  line_hl_bg = '#EFEFEF',
}

-- Helper function to set highlight groups
local function s(group, styles)
  vim.api.nvim_set_hl(0, group, styles)
end

-- Editor UI and Global Highlights
s('Normal',       { fg = p.fg, bg = p.bg })
s('Cursor',       { bg = p.active })
s('CursorLine',   { bg = p.line_hl_bg })
s('Visual',       { bg = p.selection })
s('VisualNOS',    { bg = p.inactive })
s('Search',       { fg = p.fg, bg = p.orange })
s('IncSearch',    { fg = p.fg, bg = p.orange })
s('MatchParen',   { fg = p.active, underline = true })
s('Error',        { fg = '#C33333', bg = p.red })
s('SpellBad',     { undercurl = true, sp = '#F00000' })
s('LineNr',       { fg = p.faint_fg, bg = p.bg })
s('NonText',      { fg = '#BBBBBB' })
s('SpecialKey',   { fg = '#BBBBBB' })
s('Folded',       { fg = p.faint_fg, bg = p.blue })
s('VertSplit',    { fg = '#DDDDDD', bg = p.bg })
s('StatusLine',   { fg = p.fg, bg = p.blue })
s('StatusLineNC', { fg = p.faint_fg, bg = '#EFEFEF' })
s('Pmenu',        { bg = p.inactive })
s('PmenuSel',     { fg = p.bg, bg = p.active })
s('TabLine',      { fg = p.faint_fg, bg = '#EFEFEF' })
s('TabLineSel',   { fg = p.fg, bg = p.blue })
s('TabLineFill',  { bg = '#EFEFEF' })

-- Standard Syntax Groups
s('Comment',      { fg = p.yellow_fg, bg = p.yellow })  -- plain style, yellow comments
s('Operator',     { link = 'Normal' })
s('Punctuation',  { fg = p.faint_fg })  -- faint punctuation (e.g., `;`, `,`, `(`, etc.)
s('@punctuation.delimiter',  { fg = p.faint_fg })  -- faint punctuation (e.g., `;`, `,`, `(`, etc.)
s('Delimiter',    { link = 'Normal' })
s('Todo',         { fg = p.magenta_fg, bold = true })  -- TODO items in magenta
s('DiffAdd',      { fg = '#287928' })
s('DiffDelete',   { fg = '#D73A3A' })
s('DiffChange',   { fg = '#E59B2F' })
s('DiffText',     { bg = p.blue, bold = true })
s('Ignore',       { fg = '#AAAAAA' })
s('Special',       { link = 'Normal' })
s('Title',       { fg = p.fg, bg = p.bg, bold = true })

-- Tree-sitter Specific Highlights (flat, with backgrounds)
s('@string',        { fg = p.green_fg, bg = p.green })      -- Strings → green background
s('@string.escape', { fg = p.green_fg, bg = p.green })      -- Escape sequences → green
s('@character',     { fg = p.green_fg, bg = p.green })      -- Characters → green
s('@number',        { fg = p.green_fg, bg = p.green })      -- Numbers → green background (same as strings)
-- s('@boolean',       { fg = p.green_fg, bg = p.green })      -- Booleans → green background
s('@float',         { fg = p.green_fg, bg = p.green })      -- Floats → green background

s('@lsp.typemod.parameter.declaration',          { fg = p.magenta_fg, bg = p.magenta }) -- Constants → purple background
s('@lsp.typemod.variable.declaration',          { fg = p.magenta_fg, bg = p.magenta }) -- Constants → purple background
s('@variable.parameter',          { link = 'Normal' }) -- Constants → purple background

s('Constant',          { fg = p.magenta_fg, bg = p.magenta }) -- Constants → purple background
s('@constant',          { fg = p.magenta_fg, bg = p.magenta }) -- Constants → purple background
s('@constant.builtin',  { fg = p.magenta_fg, bg = p.magenta }) -- Built-in constants → purple

-- Top-level definitions → light blue (background)
s('@type.definition', { fg = p.blue_fg, bg = p.blue })   -- Classes / Interfaces / Traits
s('@type', { fg = p.blue_fg, bg = p.blue })   -- Classes / Interfaces / Traits
-- s('@constructor',     { fg = p.blue_fg, bg = p.blue })   -- Top-level constructor functions
s('@function',        { fg = p.blue_fg, bg = p.blue })   -- Top-level functions

-- Keep method calls, function calls unhighlighted
s('@function.call',     { link = 'Normal' })
s('@function.method.call',     { link = 'Normal' })
s('@method.call',       { link = 'Normal' })

-- Parameters, properties, and variables have no special color unless explicitly defined above
-- s('@variable.parameter', { link = 'Normal' })
s('@variable.builtin', { link = 'Normal' })
s('@attribute',          { link = 'Normal' })
s('@module',          { link = 'Normal' })
s('@property',          { link = 'Normal' })
s('@variable',          { link = 'Normal' })
s('@keyword',           { link = 'Normal' })
s('@keyword.function',  { link = 'Normal' })
s('@keyword.operator',  { link = 'Normal' })
s('@label',             { link = 'Normal' })
s('@namespace',         { link = 'Normal' })
s('@tag',               { link = 'Normal' })
s('@text.title',        { bold = true })
s('@type',              { link = 'Normal' })
s('@constant',          { fg = p.magenta_fg, bg = p.magenta }) -- Constants → purple
s('@constant.builtin',  { fg = p.magenta_fg, bg = p.magenta }) -- Built-in constants → purple

s('@markup.raw.markdown_inline',  { fg = p.fg, bg = p.bg, italic = true }) -- Raw inline markdown
s('@markup.raw.block.markdown',   { fg = p.fg, bg = p.bg, italic = true }) -- Raw block markdown
