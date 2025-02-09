return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
		{ "nushell/tree-sitter-nu", build = ":TSUpdate nu" },
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({
			highlight = {
				enable = true,
			},
			indent = { enable = true },
			autotag = {
				enable = true,
			},
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"cpp",
				"csv",
				"css",
				"cuda",
				"dart",
				"dockerfile",
				"dot",
				"gitcommit",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"hcl",
				"html",
				"java",
				"javascript",
				"json",
				"julia",
				"latex",
				"make",
				"markdown",
				"markdown_inline",
				"nix",
				"pem",
				"php",
				"python",
				"regex",
				"ruby",
				"r",
				"rust",
				"ssh_config",
				"svelte",
				"sql",
				"terraform",
				"toml",
				"tsv",
				"tsx",
				"typescript",
				"vim",
				"vue",
				"xml",
				"yaml",
				"zig",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]]"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_next_end = {
						["[]"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_start = {
						["[["] = "@function.outer",
						["[]"] = "@class.outer",
					},
					goto_previous_end = {
						["]]"] = "@function.outer",
						["]["] = "@class.outer",
					},
				},
			},
		})
	end,
}