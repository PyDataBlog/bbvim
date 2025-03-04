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
					show_settings = true,
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
					adapter = "claude-3.7-sonnet",
				},
			},
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-3.7-sonnet-thought",
							},
						},
					})
				end,
			},
		})
	end,
}
