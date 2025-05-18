-- Load options
require("config.options")
require("config.keymaps")
require("config.autocommands")
local lsp_helper = require("helpers.lsp")

-- Setup lazy.nvim (package manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins defined in lua/plugins.lua
require("lazy").setup("plugins")

-- Enable the language servers
-- Neovim will look for a configuration in 'lsp/*.lua'.
-- vim.lsp.enable({ 'lua_ls' })
lsp_helper.enable_discovered_servers()
