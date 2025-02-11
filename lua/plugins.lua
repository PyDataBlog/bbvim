local plugins = {
	-- Ungrouped Plugins
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
	{ import = "plugins.flash" },
	{ import = "plugins.markview" },
	{ import = "plugins.tmux-nvim" },
	{ import = "plugins.crates" },
	{ import = "plugins.gopher" },
	{ import = "plugins.kubectl-nvim" },
	{ import = "plugins.nvim-dbee" },
	{ import = "plugins.rainbow-delimiters" },
	{ import = "plugins.rust-vim" },

	-- MINI NVIM Plugins
	{ import = "plugins.mini-ai" },
	{ import = "plugins.mini-bracketed" },
	{ import = "plugins.mini-cursorword" },
	{ import = "plugins.mini-files" },
	{ import = "plugins.mini-indentscope" },
	{ import = "plugins.mini-move" },
	{ import = "plugins.mini-pairs" },
	{ import = "plugins.mini-sessions" },
	{ import = "plugins.mini-splitjoin" },
	{ import = "plugins.mini-surround" },
	{ import = "plugins.mini-trailspace" },
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
