return {
	"nvim-lualine/lualine.nvim",
    event = "BufReadPre",
	dependencies = { "nvim-tree/nvim-web-devicons", "stevearc/overseer.nvim" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")
		local overseer = require("overseer")
		local Component = require("lualine.component")

		-- Create spinner component
		local spinner = Component:extend()
		spinner.processing = false
		spinner.spinner_index = 1

		local spinner_symbols = {
			"⠋",
			"⠙",
			"⠹",
			"⠸",
			"⠼",
			"⠴",
			"⠦",
			"⠧",
			"⠇",
			"⠏",
		}
		local spinner_symbols_len = 10

		function spinner:init(options)
			spinner.super.init(self, options)
			local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})
			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "CodeCompanionRequest*",
				group = group,
				callback = function(request)
					if request.match == "CodeCompanionRequestStarted" then
						self.processing = true
					elseif request.match == "CodeCompanionRequestFinished" then
						self.processing = false
					end
				end,
			})
		end

		function spinner:update_status()
			if self.processing then
				self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
				return spinner_symbols[self.spinner_index]
			else
				return nil
			end
		end

		lualine.setup({
			options = {
				theme = "auto",
			},
			sections = {
				lualine_x = {
					{
						spinner,
						padding = { left = 1, right = 1 },
						separator = { left = "", right = "" },
					},
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
					{
						function()
							return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
						end,
						padding = { right = 1, left = 1 },
						separator = { left = "", right = "" },
					},
					{
						"overseer",
						label = "",
						colored = true,
						symbols = {
							[overseer.STATUS.FAILURE] = "󰅚 ",
							[overseer.STATUS.CANCELED] = "󰗼 ",
							[overseer.STATUS.SUCCESS] = "󰄬 ",
							[overseer.STATUS.RUNNING] = "󰑮 ",
						},
						unique = false,
						name = nil,
						name_not = false,
						status = nil,
						status_not = false,
					},
				},
			},
		})
	end,
}