local plugins = {
	{ import = "plugins.catppuccin" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.mason" },
	{ import = "plugins.snacks-nvim" },
	{ import = "plugins.blink-cmp" },
	{ import = "plugins.nvim-lspconfig" },
	{ import = "plugins.conform" },
	{ import = "plugins.nvim-lint" },
	{ import = "plugins.which-key" },
	{ import = "plugins.nvim-ufo" },
	{ import = "plugins.grug-far" },
	{ import = "plugins.debug-dap" },
	{ import = "plugins.neotest-python" },
	{ import = "plugins.gitsigns" },
	{ import = "plugins.bufferline" },
	{ import = "plugins.overseer" },
	{ import = "plugins.lualine" },
}

require("lazy").setup(plugins, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = true,
	},
})
