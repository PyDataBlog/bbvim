local plugins = {
	-- Ungrouped Plugins
	{ import = "plugins.blink-cmp" },
	{ import = "plugins.bufferline" },
	{ import = "plugins.catppuccin" },
	{ import = "plugins.codecompanion" },
	{ import = "plugins.conform" },
	{ import = "plugins.conn-manager" },
	{ import = "plugins.copilot" },
	{ import = "plugins.copilot-chat" },
	{ import = "plugins.crates" },
	{ import = "plugins.csvview" },
	{ import = "plugins.dropbar" },
	{ import = "plugins.dadbod" },
	{ import = "plugins.debug-dap" },
	{ import = "plugins.dooing" },
	{ import = "plugins.flash" },
	{ import = "plugins.gitsigns" },
	{ import = "plugins.gopher" },
	{ import = "plugins.grug-far" },
	{ import = "plugins.hardtime" },
	{ import = "plugins.inlayhint-filler" },
	{ import = "plugins.kubectl-nvim" },
	{ import = "plugins.kuala-nvim" },
	{ import = "plugins.lualine" },
	{ import = "plugins.marks-nvim" },
	{ import = "plugins.markview" },
	{ import = "plugins.mason" },
	{ import = "plugins.neogen" },
	{ import = "plugins.neotest-python" },
	{ import = "plugins.nvim-dbee" },
	{ import = "plugins.nvim-jupyter-client" },
	{ import = "plugins.nvim-lint" },
	{ import = "plugins.nvim-lspconfig" },
	{ import = "plugins.nvim-ufo" },
	{ import = "plugins.noice" },
	{ import = "plugins.oil" },
	{ import = "plugins.overseer" },
	{ import = "plugins.rainbow-delimiters" },
	{ import = "plugins.rust-vim" },
	{ import = "plugins.snacks-nvim" },
	{ import = "plugins.tiny-glimmer" },
	{ import = "plugins.tmux-nvim" },
	{ import = "plugins.todo-comments" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.trouble" },
	{ import = "plugins.which-key" },
	{ import = "plugins.yanky" },

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
