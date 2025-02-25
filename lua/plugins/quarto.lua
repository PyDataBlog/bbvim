return {
	"quarto-dev/quarto-nvim",
	ft = { "quarto" },
	dev = false,
	opts = {
		lspFeatures = {
			languages = {
				"r",
				"python",
				"julia",
				"bash",
				"lua",
				"html",
				"dot",
				"javascript",
				"typescript",
				"ojs",
			},
		},
		codeRunner = {
			enabled = true,
			default_method = "slime",
		},
	},
	dependencies = {
		"jmbuhr/otter.nvim",
	},
}
