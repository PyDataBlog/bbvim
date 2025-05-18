return {
	"lewis6991/gitsigns.nvim",
	dependencies = { "sindrets/diffview.nvim", config = true },
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "󰍵" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "│" },
		},
	},
	config = function(_, opts)
		require("gitsigns").setup(opts)
	end,
}
