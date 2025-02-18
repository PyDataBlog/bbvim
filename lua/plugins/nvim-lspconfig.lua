return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
		{ "b0o/SchemaStore.nvim", lazy = true, version = false },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local blink_cmp = require("blink.cmp")
		-- The schemastore module will lazy-load thanks to the dependency declaration
		local schemastore = require("schemastore")

		-- Set up LSP capabilities
		local capabilities = blink_cmp.get_lsp_capabilities()

		-- Customize diagnostic signs in the sign column
		local signs = { Error = " ", Warn = " ", Hint = "💡", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- on_attach function for ruff (Python linter)
		local ruff_on_attach = function(client, bufnr)
			if client.name == "ruff" then
				-- Disable hover in favor of Pyright
				client.server_capabilities.hoverProvider = false
			end
		end

		mason_lspconfig.setup_handlers({
			-- Default handler: applies to any server without a specific handler.
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			-- Handler for gopls with custom settings.
			["gopls"] = function()
				lspconfig.gopls.setup({
					capabilities = capabilities,
					settings = {
						gopls = {
							gofumpt = true,
							codelenses = {
								gc_details = false,
								generate = true,
								regenerate_cgo = true,
								run_govulncheck = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
								vendor = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							analyses = {
								-- fieldalignment = true,
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							usePlaceholders = true,
							completeUnimported = true,
							staticcheck = true,
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							semanticTokens = true,
						},
					},
				})
			end,

			-- Handler for lua_ls with special settings.
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
							hint = {
								enable = true,
							},
						},
					},
				})
			end,

			-- Handler for ruff.
			["ruff"] = function()
				lspconfig.ruff.setup({
					capabilities = capabilities,
					on_attach = ruff_on_attach,
					init_options = {
						settings = {
							format = { preview = true },
							lint = {
								enable = true,
								preview = true,
								select = { "E", "F", "N" },
								extendSelect = {
									"W",
									"I",
									"UP007",
									"UP015",
									"FAST001",
									"FAST002",
									"FAST003",
									"RUF100",
									"RUF101",
								},
								ignore = {},
								extendIgnore = {},
							},
							codeAction = {
								disableRuleComment = { enable = true },
								fixViolation = { enable = true },
							},
							showSyntaxErrors = true,
							organizeImports = true,
							fixAll = true,
							lineLength = 120,
							exclude = {
								".git",
								".ipynb_checkpoints",
								".mypy_cache",
								".pyenv",
								".pytest_cache",
								".pytype",
								".ruff_cache",
								".venv",
								".vscode",
								"__pypackages__",
								"_build",
								"build",
								"dist",
								"site-packages",
								"venv",
							},
						},
					},
				})
			end,

			-- Handler for basedpyright (Python language server).
			["basedpyright"] = function()
				lspconfig.basedpyright.setup({
					capabilities = capabilities,
					settings = {
						disableOrganizeImports = true,
						basedpyright = { typeCheckingMode = "standard" },
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				})
			end,

			-- Handler for the JSON language server (jsonls) with SchemaStore integration.
			["jsonls"] = function()
				lspconfig.jsonls.setup({
					capabilities = capabilities,
					on_new_config = function(new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						vim.list_extend(new_config.settings.json.schemas, schemastore.json.schemas())
					end,
					settings = {
						json = {
							format = { enable = true },
							validate = { enable = true },
						},
					},
				})
			end,

			-- Handler for the YAML language server (yamlls) with SchemaStore integration.
			["yamlls"] = function()
				lspconfig.yamlls.setup({
					capabilities = vim.tbl_deep_extend("force", capabilities, {
						textDocument = {
							foldingRange = {
								dynamicRegistration = false,
								lineFoldingOnly = true,
							},
						},
					}),
					on_new_config = function(new_config)
						new_config.settings.yaml.schemas = vim.tbl_deep_extend(
							"force",
							new_config.settings.yaml.schemas or {},
							schemastore.yaml.schemas()
						)
					end,
					settings = {
						redhat = { telemetry = { enabled = false } },
						yaml = {
							keyOrdering = false,
							format = { enable = true },
							validate = true,
							schemaStore = {
								enable = false,
								url = "",
							},
						},
					},
				})
			end,
		})
	end,
}
