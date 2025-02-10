return {
	"williamboman/mason.nvim",
	-- event = "InsertEnter",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-------- LIST OF FORMATTERS/DEBUGGERS/LINTERS TO INSTALL -------------
				--- Python stuff
				"debugpy",
				"jupytext",
				"pylint",
				--- Lua stuff
				"prettier",
				"stylua",
				-- JSON stuff
				"jsonlint",
				"jq",
				-- Bash stuff
				"shellcheck",
				"beautysh",
				-- YAML stuff
				"yamllint",
				"prettierd",
				-- eslint
				"eslint_d",
				-- sql
				"sqlfluff",
				-- markdown
				"markdownlint-cli2",
				"markdown-toc",
				-- terraform
				"tflint",
				-- docker
				"hadolint",
				------- LANGUAGE SERVERS ----------
				"basedpyright",
				"ruff",
				"taplo",
				"marksman",
				"azure-pipelines-language-server",
				"bash-language-server",
				"css-lsp",
				"docker-compose-language-service",
				"dockerfile-language-server",
				"dot-language-server",
				"html-lsp",
				"json-lsp",
				"lua-language-server",
				"tailwindcss-language-server",
				"typescript-language-server",
				"yaml-language-server",
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}
