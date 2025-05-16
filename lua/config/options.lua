local opt = vim.opt -- for conciseness
local g = vim.g

opt.guicursor = "n-v-c-sm:block,i:ver50,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
opt.updatetime = 50

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.smartindent = true -- smart indent
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- system clipboard by default for all yanks
opt.clipboard = "unnamedplus"

-- disable some default providers
g["loaded_python_provider"] = 0
g["loaded_python3_provider"] = 0
g["loaded_node_provider"] = 0
g["loaded_perl_provider"] = 0
g["loaded_ruby_provider"] = 0

-- turn off cursorline
-- opt.cursorline = false

-- start terminal in insert mode
vim.cmd([[autocmd TermOpen * startinsert]])

-- turn off line numbers in terminal
vim.cmd([[autocmd TermOpen term://* setlocal nonumber norelativenumber]])

-- mark jupyter notebooks as python filetypes
vim.filetype.add({
	pattern = {
		[".*%.ipynb.*"] = "python",
		-- uses lua pattern matching
		-- rathen than naive matching
	},
})


-- vim.diagnostic.config({
-- 	virtual_text = true,
-- 	virtual_lines = { current_line = true },
-- 	underline = true,
-- 	update_in_insert = false,
-- })

-- Basic UI for LSP Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Customize diagnostic signs (optional, Catppuccin might also handle this)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

