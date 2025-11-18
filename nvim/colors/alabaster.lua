-- Neovim Colorscheme
-- Name: Alabaster
-- Author: Nikita Prokopov (Converted & Tuned by Gemini)

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'alabaster'
vim.opt.background = 'light'

-- Color Palette
local p = {
  active     = '#007ACC',
  fg         = '#000000',
  bg         = '#FFFFFF',
  float_bg   = '#FAFAFA',
  subtle_bg  = '#F6F6F6',
  
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
  border     = '#DDDDDD',
}

local diag = {
  error = { fg = '#B00020', bg = '#FFE5E5', sp = '#B00020' },
  warn  = { fg = '#8C5300', bg = '#FFF2D6', sp = '#8C5300' },
  info  = { fg = '#005A9C', bg = '#E6F1FF', sp = '#005A9C' },
  hint  = { fg = '#2F7A2F', bg = '#EEF8E4', sp = '#2F7A2F' },
}

local git = {
  add    = '#2F7A2F',
  change = '#AF6A00',
  delete = '#C33333',
}

-- Helper function to set highlight groups
local function s(group, styles)
  vim.api.nvim_set_hl(0, group, styles)
end

-- Editor UI and Global Highlights
s('Normal',       { fg = p.fg, bg = p.bg })
s('NormalNC',     { fg = p.fg, bg = p.subtle_bg })
s('NormalFloat',  { fg = p.fg, bg = p.float_bg })
s('FloatBorder',  { fg = p.border, bg = p.float_bg })
s('FloatTitle',   { fg = p.blue_fg, bg = p.float_bg, bold = true })
s('Cursor',       { bg = p.active })
s('CursorLine',   { bg = p.line_hl_bg })
s('CursorColumn', { bg = p.line_hl_bg })
s('Visual',       { bg = p.selection })
s('VisualNOS',    { bg = p.inactive })
s('Search',       { fg = p.fg, bg = p.orange })
s('IncSearch',    { fg = p.fg, bg = p.orange })
s('MatchParen',   { fg = p.active, underline = true })
s('Error',        { fg = git.delete, bg = p.red })
s('SpellBad',     { undercurl = true, sp = '#F00000' })
s('LineNr',       { fg = p.faint_fg, bg = p.bg })
s('CursorLineNr', { fg = p.blue_fg, bg = p.line_hl_bg, bold = true })
s('SignColumn',   { fg = p.faint_fg, bg = p.bg })
s('FoldColumn',   { fg = p.faint_fg, bg = p.bg })
s('EndOfBuffer',  { fg = p.inactive })
s('ColorColumn',  { bg = p.line_hl_bg })
s('Conceal',      { fg = p.faint_fg })
s('NonText',      { fg = '#BBBBBB' })
s('SpecialKey',   { fg = '#BBBBBB' })
s('Folded',       { fg = p.faint_fg, bg = p.blue })
s('VertSplit',    { fg = p.border, bg = p.bg })
s('WinSeparator', { fg = p.border, bg = p.bg })
s('StatusLine',   { fg = p.fg, bg = p.blue })
s('StatusLineNC', { fg = p.faint_fg, bg = '#EFEFEF' })
s('WinBar',       { fg = p.blue_fg, bg = p.bg })
s('WinBarNC',     { fg = p.faint_fg, bg = p.subtle_bg })
s('NormalSB',     { fg = p.fg, bg = p.subtle_bg })
s('QuickFixLine', { bg = p.selection })
s('Pmenu',        { fg = p.fg, bg = p.inactive })
s('PmenuSel',     { fg = p.bg, bg = p.active })
s('PmenuSbar',    { bg = p.inactive })
s('PmenuThumb',   { bg = p.faint_fg })
s('TabLine',      { fg = p.faint_fg, bg = '#EFEFEF' })
s('TabLineSel',   { fg = p.fg, bg = p.blue })
s('TabLineFill',  { bg = '#EFEFEF' })
s('CursorIM',     { link = 'Cursor' })
s('Whitespace',   { fg = p.inactive })

-- Standard Syntax Groups
s('Comment',      { fg = p.yellow_fg, bg = p.yellow })  -- plain style, yellow comments
s('Operator',     { link = 'Normal' })
s('Punctuation',  { fg = p.faint_fg })  -- faint punctuation (e.g., `;`, `,`, `(`, etc.)
s('@punctuation.delimiter',  { fg = p.faint_fg })  -- faint punctuation (e.g., `;`, `,`, `(`, etc.)
s('Delimiter',    { link = 'Normal' })
s('Todo',         { fg = p.magenta_fg, bold = true })  -- TODO items in magenta
s('DiffAdd',      { fg = git.add, bg = p.green })
s('DiffDelete',   { fg = git.delete, bg = p.red })
s('DiffChange',   { fg = git.change, bg = p.yellow })
s('DiffText',     { fg = p.blue_fg, bg = p.blue, bold = true })
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

-- Diagnostics
s('DiagnosticError',        { fg = diag.error.fg, bg = diag.error.bg })
s('DiagnosticWarn',         { fg = diag.warn.fg, bg = diag.warn.bg })
s('DiagnosticInfo',         { fg = diag.info.fg, bg = diag.info.bg })
s('DiagnosticHint',         { fg = diag.hint.fg, bg = diag.hint.bg })
s('DiagnosticVirtualTextError', { link = 'DiagnosticError' })
s('DiagnosticVirtualTextWarn',  { link = 'DiagnosticWarn' })
s('DiagnosticVirtualTextInfo',  { link = 'DiagnosticInfo' })
s('DiagnosticVirtualTextHint',  { link = 'DiagnosticHint' })
s('DiagnosticUnderlineError',   { undercurl = true, sp = diag.error.sp })
s('DiagnosticUnderlineWarn',    { undercurl = true, sp = diag.warn.sp })
s('DiagnosticUnderlineInfo',    { undercurl = true, sp = diag.info.sp })
s('DiagnosticUnderlineHint',    { undercurl = true, sp = diag.hint.sp })
s('DiagnosticSignError',        { fg = diag.error.fg, bg = p.bg })
s('DiagnosticSignWarn',         { fg = diag.warn.fg, bg = p.bg })
s('DiagnosticSignInfo',         { fg = diag.info.fg, bg = p.bg })
s('DiagnosticSignHint',         { fg = diag.hint.fg, bg = p.bg })
s('DiagnosticFloatingError',    { link = 'DiagnosticError' })
s('DiagnosticFloatingWarn',     { link = 'DiagnosticWarn' })
s('DiagnosticFloatingInfo',     { link = 'DiagnosticInfo' })
s('DiagnosticFloatingHint',     { link = 'DiagnosticHint' })

-- LSP
s('LspReferenceText',            { bg = p.selection })
s('LspReferenceRead',            { bg = p.selection })
s('LspReferenceWrite',           { bg = p.selection })
s('LspCodeLens',                 { fg = p.faint_fg })
s('LspCodeLensSeparator',        { fg = p.inactive })
s('LspSignatureActiveParameter', { fg = p.blue_fg, bg = p.blue, bold = true })
s('LspInlayHint',                { fg = p.faint_fg, bg = p.subtle_bg, italic = true })

-- Plugin: fzf-lua
s('FzfLuaNormal',            { link = 'NormalFloat' })
s('FzfLuaBorder',            { link = 'FloatBorder' })
s('FzfLuaTitle',             { link = 'FloatTitle' })
s('FzfLuaCursor',            { link = 'Cursor' })
s('FzfLuaCursorLine',        { fg = p.blue_fg, bg = p.line_hl_bg })
s('FzfLuaCursorLineNr',      { link = 'CursorLineNr' })
s('FzfLuaSearch',            { link = 'IncSearch' })
s('FzfLuaScrollBorderEmpty', { link = 'FzfLuaBorder' })
s('FzfLuaScrollBorderFull',  { link = 'FzfLuaBorder' })
s('FzfLuaScrollFloatEmpty',  { link = 'PmenuSbar' })
s('FzfLuaScrollFloatFull',   { link = 'PmenuThumb' })
s('FzfLuaHelpNormal',        { link = 'NormalFloat' })
s('FzfLuaHelpBorder',        { link = 'FloatBorder' })

-- Plugin: mini.nvim collection
s('MiniDiffSignAdd',       { fg = git.add, bg = p.bg })
s('MiniDiffSignChange',    { fg = git.change, bg = p.bg })
s('MiniDiffSignDelete',    { fg = git.delete, bg = p.bg })
s('MiniDiffOverAdd',       { fg = git.add, bg = p.dark_green })
s('MiniDiffOverContext',   { link = 'DiffChange' })
s('MiniDiffOverChange',    { fg = git.change, bg = p.yellow })
s('MiniDiffOverDelete',    { link = 'DiffDelete' })
s('MiniDiffSignAddLocal',  { link = 'MiniDiffSignAdd' })
s('MiniDiffSignChangeLocal',{ link = 'MiniDiffSignChange' })
s('MiniDiffSignDeleteLocal',{ link = 'MiniDiffSignDelete' })

s('MiniIndentscopeSymbol', { fg = '#CCCDCD' })
s('MiniIndentscopePrefix', { nocombine = true })

s('MiniHipatternsFixme',   { fg = p.bg, bg = diag.error.fg, bold = true })
s('MiniHipatternsHack',    { fg = p.bg, bg = diag.warn.fg, bold = true })
s('MiniHipatternsNote',    { fg = p.bg, bg = diag.info.fg, bold = true })
s('MiniHipatternsTodo',    { fg = p.bg, bg = diag.hint.fg, bold = true })

s('MiniJump',              { fg = p.bg, bg = p.magenta_fg, bold = true })
s('MiniJump2dSpot',        { fg = p.bg, bg = p.active, bold = true })
s('MiniJump2dSpotAhead',   { fg = p.magenta_fg, bg = p.selection })
s('MiniJump2dSpotUnique',  { fg = p.fg, bg = p.orange })
s('MiniJump2dDim',         { link = 'Comment' })

s('MiniStatuslineFilename',    { fg = p.blue_fg, bg = p.subtle_bg })
s('MiniStatuslineFileinfo',    { fg = p.fg, bg = p.inactive })
s('MiniStatuslineDevinfo',     { fg = p.fg, bg = p.subtle_bg })
s('MiniStatuslineInactive',    { fg = p.faint_fg, bg = p.subtle_bg })
s('MiniStatuslineModeNormal',  { fg = p.bg, bg = p.blue_fg, bold = true })
s('MiniStatuslineModeInsert',  { fg = p.bg, bg = p.green_fg, bold = true })
s('MiniStatuslineModeVisual',  { fg = p.bg, bg = p.orange, bold = true })
s('MiniStatuslineModeReplace', { fg = p.bg, bg = git.delete, bold = true })
s('MiniStatuslineModeCommand', { fg = p.bg, bg = p.magenta_fg, bold = true })
s('MiniStatuslineModeOther',   { fg = p.bg, bg = p.yellow_fg, bold = true })
