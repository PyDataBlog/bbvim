vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesActionRename",
	callback = function(event)
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(event)
		if event.data.actions.type == "move" then
			Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
		end
	end,
})

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
		if not client or type(value) ~= "table" then
			return
		end
		local p = progress[client.id]

		for i = 1, #p + 1 do
			if i == #p + 1 or p[i].token == ev.data.params.token then
				p[i] = {
					token = ev.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}
				break
			end
		end

		local msg = {} ---@type string[]
		progress[client.id] = vim.tbl_filter(function(v)
			return table.insert(msg, v.msg) or not v.done
		end, p)

		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(table.concat(msg, "\n"), "info", {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})

-- Disable autoformat for certain file types
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.b.autoformat = false
	end,
})

-- Show diagnostic virtual lines when cursor on line
local og_virt_text
local og_virt_line
vim.api.nvim_create_autocmd({ "CursorMoved", "DiagnosticChanged" }, {
	group = vim.api.nvim_create_augroup("diagnostic_only_virtlines", {}),
	callback = function()
		if og_virt_line == nil then
			og_virt_line = vim.diagnostic.config().virtual_lines
		end

		-- ignore if virtual_lines.current_line is disabled
		if not (og_virt_line and og_virt_line.current_line) then
			if og_virt_text then
				vim.diagnostic.config({ virtual_text = og_virt_text })
				og_virt_text = nil
			end
			return
		end

		if og_virt_text == nil then
			og_virt_text = vim.diagnostic.config().virtual_text
		end

		local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

		if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
			vim.diagnostic.config({ virtual_text = og_virt_text })
		else
			vim.diagnostic.config({ virtual_text = false })
		end
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	group = vim.api.nvim_create_augroup("diagnostic_redraw", {}),
	callback = function()
		pcall(vim.diagnostic.show)
	end,
})

-- Global LspAttach Autocommand
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local bufnr = event.buf

		-- Conditional setup based on client capabilities or name
		if client then
			-- Apply Ruff-specific setting
			if client.name == "ruff" or client.name == "ruff_lsp" then
				local python_hover_provider_found = false
				local active_clients = vim.lsp.get_clients({ bufnr = bufnr })
				for _, other_client in ipairs(active_clients) do
					if
						other_client.id ~= client.id
						and vim.tbl_contains({ "basedpyright", "pyright", "jedi_language_server" }, other_client.name)
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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldmethod = "expr"
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

vim.api.nvim_create_autocmd("LspDetach", { command = "setl foldexpr<" })
