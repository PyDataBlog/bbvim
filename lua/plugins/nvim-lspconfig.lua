return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"saghen/blink.cmp",
		-- "folke/snacks.nvim",
		{ "b0o/SchemaStore.nvim", lazy = true, version = false },
	},
	config = function()
		-- local lspconfig = require("lspconfig")
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
		})

		-- 5. Global LspAttach Autocommand
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local bufnr = event.buf

				-- -- Attempt to require Snacks (should be loaded due to dependency)
				-- local Snacks_ok, Snacks = pcall(require, "snacks")
				-- if not Snacks_ok then
				-- 	vim.notify(
				-- 		"Warning: 'folke/snacks.nvim' failed to load. LSP keymaps using Snacks.picker will not work.",
				-- 		vim.log.levels.WARN
				-- 	)
				-- 	Snacks = nil -- Ensure Snacks is nil if require failed
				-- end

				-- Define buffer-local keymaps using user's preferred functions
				-- local map = function(mode, keys, func, desc)
				-- 	-- Check if Snacks is available before setting maps that use it
				-- 	if desc:find("Snacks") and not Snacks then
				-- 		return -- Don't map if Snacks isn't loaded
				-- 	end
				-- 	vim.keymap.set(
				-- 		mode,
				-- 		keys,
				-- 		func,
				-- 		{ buffer = bufnr, noremap = true, silent = true, desc = "LSP: " .. desc }
				-- 	)
				-- end

				-- Your LSP keymaps using Snacks.picker
				-- map("n", "gd", function()
				-- 	Snacks.picker.lsp_definitions()
				-- end, "Snacks: Goto Definition")
				-- map("n", "gD", function()
				-- 	Snacks.picker.lsp_declarations()
				-- end, "Snacks: Goto Declaration")
				-- map("n", "gr", function()
				-- 	Snacks.picker.lsp_references()
				-- end, "Snacks: References")
				-- map("n", "gI", function()
				-- 	Snacks.picker.lsp_implementations()
				-- end, "Snacks: Goto Implementation")
				-- map("n", "gy", function()
				-- 	Snacks.picker.lsp_type_definitions()
				-- end, "Snacks: Goto T[y]pe Definition")
				-- map("n", "<leader>ss", function()
				-- 	Snacks.picker.lsp_symbols()
				-- end, "Snacks: LSP Symbols")
				-- map("n", "<leader>sS", function()
				-- 	Snacks.picker.lsp_workspace_symbols()
				-- end, "Snacks: LSP Workspace Symbols")
				--
				-- -- Standard LSP actions (useful fallbacks or additions)
				-- map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
				-- map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
				-- map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				-- map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				--
				-- -- Diagnostic keymaps (remain useful)
				-- map("n", "<leader>ld", vim.diagnostic.open_float, "Diagnostic Float")
				-- map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
				-- map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
				-- map("n", "<leader>lq", vim.diagnostic.setqflist, "Diagnostic [Q]uickfix List")
				-- map("n", "<leader>ll", vim.diagnostic.setloclist, "Diagnostic [L]ocation List")

				-- Conditional setup based on client capabilities or name
				if client then
					-- Apply Ruff-specific setting
					if client.name == "ruff" or client.name == "ruff_lsp" then
						local python_hover_provider_found = false
						local active_clients = vim.lsp.get_active_clients({ bufnr = bufnr })
						for _, other_client in ipairs(active_clients) do
							if
								other_client.id ~= client.id
								and vim.tbl_contains(
									{ "basedpyright", "pyright", "jedi_language_server" },
									other_client.name
								)
								and other_client.supports_method("textDocument/hover")
							then
								python_hover_provider_found = true
								break
							end
						end
						if python_hover_provider_found then
							client.server_capabilities.hoverProvider = false
						end
					end

					-- Enable features based on capabilities
					if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
						local highlight_augroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
						vim.api.nvim_create_autocmd(
							{ "CursorHold", "CursorHoldI" },
							{ group = highlight_augroup, buffer = bufnr, callback = vim.lsp.buf.document_highlight }
						)
						vim.api.nvim_create_autocmd(
							{ "CursorMoved", "CursorMovedI" },
							{ group = highlight_augroup, buffer = bufnr, callback = vim.lsp.buf.clear_references }
						)
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("UserLspDetachHighlights", { clear = true }),
							callback = function(detach_event)
								if detach_event.buf == bufnr then
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({ group = "LspDocumentHighlight", buffer = bufnr })
								end
							end,
						})
					end
					if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens, bufnr) then
						vim.lsp.codelens.refresh()
						vim.api.nvim_create_autocmd(
							{ "BufEnter", "CursorHold", "InsertLeave" },
							{ buffer = bufnr, callback = vim.lsp.codelens.refresh }
						)
					end
					-- Inlay hints disabled by default, enable if desired
					-- if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
					--     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					-- end
				end
			end,
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
