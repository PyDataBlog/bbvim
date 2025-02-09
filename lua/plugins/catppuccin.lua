return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		-- Set up Catppuccin
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false, -- disables setting the background color.
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			no_underline = false, -- Force no underline
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
				-- miscs = {}, -- Uncomment to turn off hard-coded styles
			},
			color_overrides = {},
			custom_highlights = {},
			default_integrations = true,
			integrations = {
				rainbow_delimiters = true,
				render_markdown = true,
				lsp_trouble = true,
				dropbar = true,
				cmp = true,
				blink_cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
				dap = true,
				dap_ui = true,
				neotest = true,
				notify = false,
				noice = true,
				ufo = true,
				overseer = true,
				flash = true,
				mason = false,
				semantic_tokens = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				telescope = {
					enabled = true,
				},
				indent_blankline = {
					enabled = true,
					scope_color = "text", -- catppuccin color (e.g., `lavender`) Default: text
					colored_indent_levels = false,
				},
				-- For more plugin integrations, please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		})

		-- Retrieve the color palette
		local palette = require("catppuccin.palettes").get_palette("mocha")

		if palette == nil then
			return
		end

		-- Directly integrate the line-number-change-mode functionality
		local group = vim.api.nvim_create_augroup("LineNumberChangeMode", { clear = true })

		vim.api.nvim_create_autocmd("ModeChanged", {
			group = group,
			callback = function()
				local new_mode = vim.v.event.new_mode
				local line_number_map = {
					i = {
						bg = palette.green,
						fg = palette.mantle,
						bold = true,
					},
					n = {
						bg = palette.blue,
						fg = palette.mantle,
						bold = true,
					},
					R = {
						bg = palette.maroon,
						fg = palette.mantle,
						bold = true,
					},
					v = {
						bg = palette.mauve,
						fg = palette.mantle,
						bold = true,
					},
					V = {
						bg = palette.mauve,
						fg = palette.mantle,
						bold = true,
					},
				}

				local highlight = line_number_map[new_mode]
				if highlight then
					vim.api.nvim_set_hl(0, "CursorLineNr", highlight)
				end
			end,
		})
	end,
}
