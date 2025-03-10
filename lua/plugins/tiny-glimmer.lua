return {
	"rachartier/tiny-glimmer.nvim",
	event = "BufReadPre",
	opts = {
		disable_warnings = false,
		animations = {
			fade = {
				from_color = "#FF757F",
			},
			reverse_fade = {
				from_color = "#4FD6BE",
			},
		},
		presets = {
			pulsar = {
				enabled = true,
			},
		},
		overwrite = {
			search = {
				enabled = false,
			},
			paste = {
				enabled = true,
			},
			undo = {
				enabled = true,
			},
			redo = {
				enabled = true,
			},
		},
	},
}
