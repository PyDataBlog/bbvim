return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				header = [[
██████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
██╔══██╗██╔══██╗██║   ██║██║████╗ ████║
██████╔╝██████╔╝██║   ██║██║██╔████╔██║
██╔══██╗██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
██████╔╝██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
			},
			sections = {
				-- {
				-- 	pane = 2,
				-- 	section = "terminal",
				-- 	cmd = "chafa ~/.config/nvim/pngegg.png --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
				-- 	height = 17,
				-- 	padding = 1,
				-- },
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
		explorer = { enabled = true },
		indent = { enabled = false },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
			style = "fancy",
		},
		notify = { enabled = true },
		image = { enabled = true },
		git = { enabled = true },
		gitbrowse = { enabled = true },
		profiler = { enabled = true },
		rename = { enabled = true },
		scratch = { enabled = true },
		terminal = { enabled = true },
		toggle = { enabled = true },
		picker = { enabled = true, sources = {
			files = { hidden = true },
		} },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = true },
		styles = {
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
		dim = { enabled = true },
		lazygit = { enabled = true },
		zen = { enabled = true },
		bufdelete = { enabled = true },
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
