return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"saghen/blink.cmp",
		{ "b0o/SchemaStore.nvim", lazy = true, version = false },
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local blink_cmp = require("blink.cmp")
		local schemastore = require("schemastore")

		-- 1. Define Server-Specific Configurations (Only your original servers)
		local servers = {
			gopls = {
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
			},
			lua_ls = {
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
						workspace = {
							checkThirdParty = false, -- Performance optimization for large projects
							-- library = vim.api.nvim_get_runtime_file("", true), -- If you need runtime files included
						},
					},
				},
			},
			ruff = {
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
						-- fixAll = true, -- Consider triggering this manually or via code action
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
			},
			basedpyright = {
				settings = {
					basedpyright = {
						disableOrganizeImports = true, -- Let ruff handle imports if used together
						typeCheckingMode = "standard",
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							-- ignore = {}, -- Specify paths to ignore if needed
						},
					},
				},
			},
			jsonls = {
				on_new_config = function(new_config)
					new_config.settings.json.schemas = new_config.settings.json.schemas or {}
					vim.list_extend(new_config.settings.json.schemas, schemastore.json.schemas())
				end,
				settings = {
					json = {
						format = { enable = true },
						validate = { enable = true },
						schemas = {},
					},
				},
			},
			yamlls = {
				on_new_config = function(new_config)
					new_config.settings.yaml.schemas =
						vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, schemastore.yaml.schemas())
				end,
				settings = {
					redhat = { telemetry = { enabled = false } },
					yaml = {
						keyOrdering = false,
						format = { enable = true },
						validate = true,
						schemaStore = {
							enable = false, -- Use schemastore.nvim integration
							url = "",
						},
						schemas = {},
					},
				},
			},
			typos_lsp = {
				cmd_env = { RUST_LOG = "warning" },
				init_options = {
					-- Defaults to error.
					diagnosticSeverity = "Warning",
				},
			},
		}

		-- 2. Get LSP capabilities
		local capabilities = blink_cmp.get_lsp_capabilities(nil, true)

		-- 3. Configure servers and collect names for Mason
		local ensure_installed_servers = {}
		for server_name, config in pairs(servers) do
			if config ~= false then
				config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
				vim.lsp.config(server_name, config)
				table.insert(ensure_installed_servers, server_name)
			end
		end

		-- 4. Setup Mason-LSPConfig
		mason_lspconfig.setup({
			ensure_installed = ensure_installed_servers,
			automatic_enable = true,
		})

		-- 6. Configure Diagnostics
		local signs = { Error = " ", Warn = " ", Hint = "💡", Info = " " }
		vim.fn.sign_define("DiagnosticSignError", { text = signs.Error, texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = signs.Warn, texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = signs.Info, texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = signs.Hint, texthl = "DiagnosticSignHint" })

		vim.diagnostic.config({
			virtual_text = {
				severity = { min = vim.diagnostic.severity.WARN },
				source = "if_many",
				spacing = 4,
				prefix = "●",
			},
			virtual_lines = false, -- Disable virtual lines?
			signs = { active = signs },
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "if_many",
				header = "",
				prefix = "",
			},
		})

		vim.lsp.set_log_level("off")
	end,
}
