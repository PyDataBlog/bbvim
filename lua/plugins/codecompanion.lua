return {
	"olimorris/codecompanion.nvim",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			display = {
				chat = {
					render_headers = false,
				},
			},
			strategies = {
				chat = {
					adapter = "copilot",
					slash_commands = {
						["file"] = {
							opts = {
								provider = "snacks",
							},
						},
						["buffer"] = {
							opts = {
								provider = "snacks",
							},
						},
					},
				},
				inline = {
					adapter = "copilot",
				},
			},
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-3.5-sonnet",
							},
						},
					})
				end,
			},
		})
	end,
}
