local opt = vim.opt

opt.number = true         -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = true     -- Highlight the current line

opt.tabstop = 2           -- Number of spaces a <Tab> in the file counts for
opt.shiftwidth = 2        -- Number of spaces to use for each step of (auto)indent
opt.softtabstop = 2       -- Number of spaces a <Tab> counts for while performing editing operations
opt.expandtab = true      -- Use spaces instead of tabs

opt.ignorecase = true     -- Ignore case in search patterns
opt.smartcase = true      -- Override 'ignorecase' if the search pattern contains upper case characters

opt.hlsearch = true       -- Highlight all matches on search
opt.incsearch = true      -- Show search results incrementally

opt.termguicolors = true  -- Enable 24-bit RGB color in the TUI
opt.signcolumn = "yes"    -- Always show the sign column, otherwise it would shift the text
opt.wrap = false          -- Disable line wrapping

-- Better completion experience (even without nvim-cmp, for built-in omnifunc)
opt.completeopt = { "menu", "menuone", "noselect" }

-- Basic UI for LSP Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Customize diagnostic signs (optional, Catppuccin might also handle this)
-- Ensure you have a Nerd Font installed and configured in your terminal for these icons
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

