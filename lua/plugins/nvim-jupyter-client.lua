return {
	"geg2102/nvim-jupyter-client",
	dependencies = {
		"geg2102/nvim-python-repl",
		dependencies = "nvim-treesitter",
		ft = { "python" },
		config = function()
			require("nvim-python-repl").setup({
				execute_on_send = false,
				vsplit = false,
			})
		end,
	},
	ft = "python",
	config = function()
		require("nvim-jupyter-client").setup({})
	end,
}
