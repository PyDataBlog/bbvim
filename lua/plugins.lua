local plugins = {
	-- UI and Appearance
	{ import = "plugins.bufferline" },
	{ import = "plugins.catppuccin" },
	{ import = "plugins.dropbar" },
	{ import = "plugins.lualine" },
	{ import = "plugins.noice" },
	{ import = "plugins.rainbow-delimiters" },
	{ import = "plugins.smear-cursor" },
	-- { import = "plugins.tiny-glimmer" },
	{ import = "plugins.todo-comments" },
	{ import = "plugins.trouble" },

	-- LSP and Code Intelligence
	{ import = "plugins.inlayhint-filler" },
	{ import = "plugins.mason" },
	{ import = "plugins.neogen" },
	{ import = "plugins.nvim-lint" },
	{ import = "plugins.nvim-lspconfig" },
	{ import = "plugins.nvim-ufo" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.conform" },

	-- Navigation and Motion
	{ import = "plugins.flash" },
	{ import = "plugins.marks-nvim" },
	{ import = "plugins.oil" },
	{ import = "plugins.which-key" },

	-- Language-specific Tools
	{ import = "plugins.crates" },
	{ import = "plugins.gopher" },
	{ import = "plugins.quarto" },
	{ import = "plugins.rust-vim" },
	{ import = "plugins.rustacenvim" },
	{ import = "plugins.nvim-jupyter-client" },

	-- AI and Assistance
	{ import = "plugins.codecompanion" },
	{ import = "plugins.copilot" },
	{ import = "plugins.copilot-chat" },
	{ import = "plugins.mcphub-nvim" },

	-- Git Integration
	{ import = "plugins.gitsigns" },

	-- Database and Data
	{ import = "plugins.dadbod" },
	{ import = "plugins.nvim-dbee" },
	{ import = "plugins.csvview" },

	-- Editing Enhancements
	{ import = "plugins.blink-cmp" },
	{ import = "plugins.dial" },
	{ import = "plugins.grug-far" },
	{ import = "plugins.hardtime" },
	{ import = "plugins.markview" },
	{ import = "plugins.yanky" },

	-- Testing and Tasks
	{ import = "plugins.debug-dap" },
	{ import = "plugins.neotest-python" },
	{ import = "plugins.overseer" },

	-- Integration Tools
	{ import = "plugins.conn-manager" },
	{ import = "plugins.kubectl-nvim" },
	{ import = "plugins.kuala-nvim" },
	{ import = "plugins.tmux-nvim" },
	{ import = "plugins.dooing" },
	{ import = "plugins.snacks-nvim" },

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
