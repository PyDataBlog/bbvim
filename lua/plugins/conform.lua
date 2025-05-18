return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>ft", -- "Format Toggle (buffer)"
			function()
				-- Get current buffer's disable_autoformat status, default to false if not set
				local isDisabledBuffer = vim.b.disable_autoformat == true
				if isDisabledBuffer then
					vim.cmd("FormatEnable!") -- Enable for buffer
					vim.notify("Enabled autoformatting for current buffer", vim.log.levels.INFO, { title = "Conform" })
				else
					vim.cmd("FormatDisable!") -- Disable for buffer
					vim.notify("Disabled autoformatting for current buffer", vim.log.levels.INFO, { title = "Conform" })
				end
			end,
			desc = "Toggle autoformat for current buffer",
		},
		{
			"<leader>fT", -- "Format Toggle (Global)"
			function()
				-- Get global disable_autoformat status, default to false if not set
				local isDisabledGlobal = vim.g.disable_autoformat == true
				if isDisabledGlobal then
					vim.cmd("FormatEnable") -- Enable globally
					vim.notify("Enabled autoformatting globally", vim.log.levels.INFO, { title = "Conform" })
				else
					vim.cmd("FormatDisable") -- Disable globally
					vim.notify("Disabled autoformatting globally", vim.log.levels.INFO, { title = "Conform" })
				end
			end,
			desc = "Toggle autoformat globally",
		},
	},
	-- Options passed to conform.setup()
	opts = {
		notify_on_error = true,
		formatters_by_ft = {
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			svelte = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			markdown = { "prettierd" },
			graphql = { "prettierd" },
			liquid = { "prettierd" },
			lua = { "stylua" },
			python = {
				"ruff_fix",
				"ruff_format",
				"ruff_organize_imports",
			},
			sql = { "sqlfluff" },
		},

		-- format_on_save is now a function to check our disable flags
		format_on_save = function(bufnr)
			-- Check if autoformatting is disabled for the buffer or globally
			-- Note: vim.b[bufnr].disable_autoformat might be nil, which is fine (evaluates to false)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				vim.notify("Autoformat on save disabled.", vim.log.levels.TRACE, { title = "Conform" })
				return
			end

			-- If not disabled, return your original format_on_save options
			return {
				lsp_fallback = true,
				async = false, -- Your original setting
				timeout_ms = 1000, -- Your original setting
			}
		end,
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		-- User command to disable formatting
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- :FormatDisable! disables autoformat for the current buffer only
				vim.b.disable_autoformat = true
				vim.notify("Disabled autoformat for current buffer", vim.log.levels.INFO, { title = "Conform" })
			else
				-- :FormatDisable disables autoformat globally
				vim.g.disable_autoformat = true
				vim.notify("Disabled autoformat globally", vim.log.levels.INFO, { title = "Conform" })
			end
		end, {
			desc = "Disable autoformat-on-save (globally or !buffer-local)",
			bang = true, -- Allows the `!` variant
		})

		-- User command to enable formatting
		vim.api.nvim_create_user_command("FormatEnable", function(args)
			if args.bang then
				-- :FormatEnable! enables autoformat for the current buffer only
				-- It does not affect the global vim.g.disable_autoformat setting
				vim.b.disable_autoformat = false
				vim.notify("Enabled autoformat for current buffer", vim.log.levels.INFO, { title = "Conform" })
			else
				-- :FormatEnable enables autoformat globally AND for the current buffer
				vim.g.disable_autoformat = false
				vim.b.disable_autoformat = false
				vim.notify(
					"Enabled autoformat globally (and for current buffer)",
					vim.log.levels.INFO,
					{ title = "Conform" }
				)
			end
		end, {
			desc = "Re-enable autoformat-on-save (globally or !buffer-local)",
			bang = true,
		})
	end,
}
