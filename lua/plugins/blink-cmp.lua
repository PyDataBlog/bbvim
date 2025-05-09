return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	-- optional: provides snippets for the snippet source
	dependencies = {
		{
			"echasnovski/mini.snippets",
			version = "*",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				local mini_snippets = require("mini.snippets")
				mini_snippets.setup({
					-- Array of snippets and loaders (see |MiniSnippets.config| for details).
					-- Nothing is defined by default. Add manually to have snippets to match.
					snippets = { mini_snippets.gen_loader.from_lang() },

					-- Module mappings. Use `''` (empty string) to disable one.
					mappings = {
						-- Expand snippet at cursor position. Created globally in Insert mode.
						expand = "<C-j>",

						-- Interact with default `expand.insert` session.
						-- Created for the duration of active session(s)
						jump_next = "<C-l>",
						jump_prev = "<C-h>",
						stop = "<C-c>",
					},

					-- Functions describing snippet expansion. If `nil`, default values
					-- are `MiniSnippets.default_<field>()`.
					expand = {
						-- Resolve raw config snippets at context
						prepare = nil,
						-- Match resolved snippets at cursor position
						match = nil,
						-- Possibly choose among matched snippets
						select = nil,
						-- Insert selected snippet
						insert = nil,
					},
				})
			end,
		},
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		-- { "moyiz/blink-emoji.nvim" },
		{ "fang2hou/blink-copilot" },
	},

	-- use a release tag to download pre-built binaries
	-- version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	build = "cargo build --release",
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			["<C-y>"] = { "select_and_accept" },

			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "snippet_backward" },
			["<C-n>"] = {
				function(cmp)
					if vim.b[vim.api.nvim_get_current_buf()].nes_state then
						cmp.hide()
						return (
							require("copilot-lsp.nes").apply_pending_nes()
							and require("copilot-lsp.nes").walk_cursor_end_edit()
						)
					end
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-k>"] = {},
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
				},
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "label", "label_description", gap = 1 },
						{ gap = 2, "kind_icon", "kind" },
					},
				},
				border = "rounded",
			},
			list = {
				selection = { preselect = true, auto_insert = false },
			},
			ghost_text = {
				enabled = false,
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "normal",
		},
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			-- default = { "lazydev", "lsp", "path", "snippets", "buffer", "dadbod", "emoji" },
			default = { "lazydev", "lsp", "path", "snippets", "buffer", "dadbod", "copilot" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
				-- emoji = {
				-- 	module = "blink-emoji",
				-- 	name = "Emoji",
				-- 	score_offset = 15, -- Tune by preference
				-- 	opts = { insert = true }, -- Insert emoji (default) or complete its name
				-- },
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
