return {
	"mason-org/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				----------- LANGUAGE SERVERS -----------------------------------------
				"lua-language-server",
				"basedpyright",
				"ruff",
				"gopls",
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
				"typos-lsp",
				"harper-ls",
				"html-lsp",
				"json-lsp",
				"rust-analyzer",
				"helm-ls",
				"terraform-ls",
				"zls",

				-------- LIST OF FORMATTERS/DEBUGGERS/LINTERS TO INSTALL -------------
				--- Python stuff
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
				-- go
				"gotests",
				"gomodifytags",
				"goimports",
				"impl",
				"iferr",
				"gotestsum",
				"golines",
				"go-debug-adapter",
				-- rust
				"codelldb",
				-- makefiles
				"checkmake",
			},
			auto_update = false,
			run_mason_update_on_startup = true,
		})
	end,
}
