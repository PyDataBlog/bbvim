return {
	"DestopLine/scratch-runner.nvim",
	dependencies = "folke/snacks.nvim",
	opts = {
		sources = {
			typescript = { { "deno" }, extension = "ts" },
			javascript = { "node" },
			python = { "python3" }, -- "py" or "python" if you are on Windows
			rust = {
				function(file_path, bin_path)
					return { "rustc", file_path, "-o", bin_path }
				end,
				extension = "rs",
				binary = true,
			},
		},
	},
}
