return {
	"kevinhwang91/nvim-ufo",
	event = "VimEnter",
	init = function()
		vim.o.foldcolumn = "auto"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldnestmax = 0
		vim.o.foldenable = true
		vim.o.foldmethod = "indent"

		vim.opt.fillchars = {
			fold = " ",
			foldopen = "+",
			foldsep = "│",
			foldclose = "-",
			eob = "⋅",
		}
	end,
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			opts = function()
				local builtin = require("statuscol.builtin")
				return {
					relculright = true,
					bt_ignore = { "nofile", "prompt", "terminal", "packer" },
					ft_ignore = {
						"NvimTree",
						"dashboard",
						"nvcheatsheet",
						"dapui_watches",
						"dap-repl",
						"dapui_console",
						"dapui_stacks",
						"dapui_breakpoints",
						"dapui_scopes",
						"help",
						"vim",
						"alpha",
						"dashboard",
						"neo-tree",
						"Trouble",
						"noice",
						"lazy",
						"toggleterm",
						"snacks_dashboard",
						"snacks_notif",
						"snacks_terminal",
						"snacks_win",
					},
					segments = {
						{ text = { " " } },
						{
							text = { builtin.foldfunc },
							click = "v:lua.ScFa",
							maxwidth = 1,
							colwidth = 1,
							auto = false,
						},
						{ text = { " " } },
						{
							sign = {
								name = { ".*" },
								maxwidth = 1,
								colwidth = 1,
							},
							auto = true,
							click = "v:lua.ScSa",
						},
						{
							text = { " ", " ", builtin.lnumfunc, " " },
							click = "v:lua.ScLa",
							condition = { true, builtin.not_empty },
						},
						{
							sign = {
								namespace = { "gitsign.*" },
								maxwidth = 1,
								colwidth = 1,
								auto = false,
							},
							click = "v:lua.ScSa",
						},
						{
							text = { " " },
							hl = "Normal",
							condition = { true, builtin.not_empty },
						},
					},
				}
			end,
		},
	},
	opts = {
		close_fold_kinds_for_ft = { default = { "imports" } },
		provider_selector = function()
			return { "treesitter", "indent" }
		end,
		fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
			local result = {}
			local line = vim.fn.getline(lnum)
			local lines_count = endLnum - lnum + 1
			local fold_info = ("  %d lines "):format(lines_count)
			local fold_info_width = vim.fn.strdisplaywidth(fold_info)

			-- Calculate available width for the line content
			local content_width = width - fold_info_width
			local line_content = line
			local line_content_width = vim.fn.strdisplaywidth(line_content)

			if line_content_width > content_width then
				line_content = truncate(line_content, content_width)
				line_content_width = vim.fn.strdisplaywidth(line_content)
			end

			-- Decorative padding
			local fill_char = "─"
			local padding_width = content_width - line_content_width
			local padding = fill_char:rep(math.floor(padding_width / vim.fn.strdisplaywidth(fill_char)))

			-- Construct the virtual text without highlighting
			table.insert(result, { line_content, nil }) -- No highlight group
			if padding ~= "" then
				table.insert(result, { padding, nil }) -- No highlight group
			end
			table.insert(result, { fold_info, nil }) -- No highlight group

			return result
		end,
	},
}