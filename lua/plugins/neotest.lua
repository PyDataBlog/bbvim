---@diagnostic disable: missing-fields

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- Test adapters
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-go",
		"rouge8/neotest-rust",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = {
						justMyCode = false,
						console = "integratedTerminal",
					},
					args = { "--log-level", "DEBUG" },
					runner = "pytest",
					is_test_file = function(file_path)
						return file_path:match("test_.*%.py$") ~= nil
					end,
				}),
				require("neotest-go")({
					args = { "-count=1", "-timeout=60s", "-race" },
					experimental = {
						test_table = true,
					},
				}),
				require("neotest-rust")({
					args = { "--no-capture" },
					dap_adapter = "rt_lldb",
				}),
			},
			-- Global configuration
			discovery = {
				-- Drastically improve performance in ginormous projects by
				-- only AST-parsing the currently opened buffer.
				enabled = false,
				-- Number of workers to parse files concurrently.
				-- A value of 0 automatically assigns number based on CPU.
				-- Set to 1 if experiencing lag.
				concurrent = 0,
			},
			running = {
				-- Run tests concurrently when an adapter provides multiple commands to run.
				concurrent = true,
			},
			summary = {
				-- Enable/disable animation of icons.
				animated = true,
				-- Expand user's home directory in file paths.
				expand_errors = true,
				-- Follow the currently focused test in the summary window.
				follow = true,
				-- Open on startup.
				open = "botright vsplit | vertical resize 50",
			},
			output = {
				-- Open output as integrated terminal when possible
				open_on_run = "short",
			},
			output_panel = {
				-- Enable/disable auto open of the output panel
				enabled = true,
				open = "botright split | resize 15",
			},
			status = {
				-- Display status signs
				enabled = true,
				signs = true,
				virtual_text = true,
			},
			strategies = {
				-- Define your integrated terminal strategy
				integrated = {
					height = 40,
					width = 120,
				},
			},
			icons = {
				child_indent = "│",
				child_prefix = "├",
				collapsed = "─",
				expanded = "╮",
				failed = "✘",
				final_child_indent = " ",
				final_child_prefix = "╰",
				non_collapsible = "─",
				notify = "",
				passed = "✓",
				running = "⟳",
				running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
				skipped = "○",
				unknown = "?",
				watching = "",
			},
			floating = {
				border = "rounded",
				max_height = 0.6,
				max_width = 0.6,
				options = {},
			},
			-- Logging level for neotest. Can be "trace", "debug", "info", "warn", "error"
			log_level = vim.log.levels.WARN,
		})
	end,
	keys = {
		{
			"<leader>tm",
			function()
				require("neotest").run.run()
			end,
			desc = "Test Method",
		},
		{
			"<leader>tM",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Test Method DAP",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Test Class",
		},
		{
			"<leader>tF",
			function()
				require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
			end,
			desc = "Test Class DAP",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Test Summary",
		},
	},
}
