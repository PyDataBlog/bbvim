return {
	"nvim-neotest/neotest-python",
	ft = "python",
	dependencies = {
        {
            "nvim-neotest/neotest",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-treesitter/nvim-treesitter",
                "antoinemadec/FixCursorHold.nvim",
            },
        },
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		vim.cmd([[ autocmd FileType python lua require('dapui').setup() ]])
		local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
		require("dap-python").setup(path)
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
			},
		})
	end,
}