local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = ","

----------------------- General mappings ------------------------------
keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
keymap.set("n", "<leader>yy", "ggVGy", { desc = "Yank whole buffer" })

-- Insert lines above/below without leaving normal mode
keymap.set("n", "oo", "o<Esc>k", { silent = true })
keymap.set("n", "OO", "O<Esc>j", { silent = true })

--------------------  CMD enter command mode with ; -------------------
keymap.set("n", ";", ":", { desc = "CMD enter command mode" })

--------------------  Movement Keys in Insert Mode -------------------
keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Move Beginning of line" }) -- move to the beginning of the line
keymap.set("i", "<C-e>", "<End>", { desc = "Move End of line" }) -- move to the end of the line
keymap.set("i", "<C-h>", "<Left>", { desc = "Move Left" }) -- move left
keymap.set("i", "<C-l>", "<Right>", { desc = "Move Right" }) -- move right
keymap.set("i", "<C-j>", "<Down>", { desc = "Move Down" }) -- move down
keymap.set("i", "<C-k>", "<Up>", { desc = "Move Up" }) -- move up

--------------------  use jk to exit insert mode -------------------
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

--------------------  clear search highlights -------------------
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlights and resume normal operations" })

--------------------  File operations -------------------
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "File Save" }) -- save current file
keymap.set("n", "<leader>Y>", "<cmd>%y+<CR>", { desc = "File Copy whole" }) -- copy the whole file to clipboard

------------------------------- Overseer mappings -----------------------------------
keymap.set("n", "<leader>ow", "<cmd>OverseerToggle<CR>", { desc = "Task list" })
keymap.set("n", "<leader>oo", "<cmd>OverseerRun<CR>", { desc = "Run task" })
keymap.set("n", "<leader>or", "<cmd>OverseerRunCmd<CR>", { desc = "Run CMD task" })
keymap.set("n", "<leader>oq", "<cmd>OverseerQuickAction<CR>", { desc = "Action recent task" })
keymap.set("n", "<leader>oi", "<cmd>OverseerInfo<CR>", { desc = "Overseer Info" })
keymap.set("n", "<leader>ob", "<cmd>OverseerBuild<CR>", { desc = "Task builder" })
keymap.set("n", "<leader>ot", "<cmd>OverseerTaskAction<CR>", { desc = "Task action" })
keymap.set("n", "<leader>oc", "<cmd>OverseerClearCache<CR>", { desc = "Clear cache" })
keymap.set("n", "<leader>ol", "<cmd>OverseerLoadBundle<CR>", { desc = "Load saved bundle" })
keymap.set("n", "<leader>os", "<cmd>OverseerSaveBundle<CR>", { desc = "Save task bundle" })
keymap.set("n", "<leader>od", "<cmd>OverseerDeleteBundle<CR>", { desc = "Delete task bundle" })

-------------------------------- Terminal -----------------------------------------------
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

------------------------------ Bufferline mappings ------------------------------
keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin buffer" })
keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })

------------------------------  window management ---------------------------------
keymap.set("n", "<leader>s|", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>s-", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>s=", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tb", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

------------------ Gitsigns mappings  -------------------
-- Navigation
keymap.set("n", "]g", "<cmd>lua require('gitsigns').next_hunk()<CR>", { desc = "Next Hunk" })
keymap.set("n", "[g", "<cmd>lua require('gitsigns').prev_hunk()<CR>", { desc = "Previous Hunk" })

-- Actions
keymap.set("n", "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<CR>", { desc = "Stage Hunk" })
keymap.set("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", { desc = "Reset Hunk" })
keymap.set(
	"v",
	"<leader>gs",
	"<cmd>lua require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })<CR>",
	{ desc = "Stage Selected Hunk" }
)
keymap.set(
	"v",
	"<leader>gr",
	"<cmd>lua require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })<CR>",
	{ desc = "Reset Selected Hunk" }
)
keymap.set("n", "<leader>gS", "<cmd>lua require('gitsigns').stage_buffer()<CR>", { desc = "Stage Buffer" })
keymap.set("n", "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<CR>", { desc = "Reset Buffer" })
keymap.set("n", "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", { desc = "Undo Stage Hunk" })
keymap.set("n", "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", { desc = "Preview Hunk" })
keymap.set("n", "<leader>gb", "<cmd>lua require('gitsigns').blame_line({ full = true })<CR>", { desc = "Blame Line" })
keymap.set(
	"n",
	"<leader>gB",
	"<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>",
	{ desc = "Toggle Line Blame" }
)
keymap.set("n", "<leader>gd", "<cmd>lua require('gitsigns').diffthis()<CR>", { desc = "Diff This" })
keymap.set("n", "<leader>gD", "<cmd>lua require('gitsigns').diffthis('~')<CR>", { desc = "Diff This ~" })

-- Text object
keymap.set({ "o", "x" }, "ih", "<cmd>lua require('gitsigns').select_hunk()<CR>", { desc = "Select Hunk" })

------------------------------- Trim whitespace mappings -----------------------------------
keymap.set("n", "<leader>tw", "<cmd>lua MiniTrailspace.trim()<cr>", { desc = "Trim trailing whitespace" })

------------------------------- Mini-files mappings -----------------------------------
keymap.set("n", "<leader>mf", "<cmd>lua MiniFiles.open()<cr>", { desc = "Toggle Mini Files" })

------------------------------- Oil mappings -----------------------------------
keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil" })

------------------------------ Which Key mappings ------------------------------
keymap.set("n", "<leader>wK", "<cmd>WhichKey<CR>", { desc = "Display All Keymaps" })
keymap.set(
	"n",
	"<leader>wk",
	"<cmd>lua vim.cmd('WhichKey ' .. vim.fn.input('WhichKey: '))<CR>",
	{ desc = "Whichkey Query Lookup" }
)

------------------------------ Neotest mappings --------------------------------------------
keymap.set("n", "<leader>tm", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Test Method" })
keymap.set(
	"n",
	"<leader>tM",
	"<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
	{ desc = "Test Method DAP" }
)
keymap.set("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = "Test Class" })
keymap.set(
	"n",
	"<leader>tF",
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
	{ desc = "Test Class DAP" }
)
keymap.set("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Test Summary" })

------------------------------ Kulala mappings -----------------------------------
keymap.set("n", "<leader>kr", "<cmd>lua require('kulala').run()<CR>", { desc = "Run the current request" })
keymap.set("n", "<leader>kp", "<cmd>lua require('kulala').jump_prev()<CR>", { desc = "Jump to the previous request" })
keymap.set("n", "<leader>kn", "<cmd>lua require('kulala').jump_next()<CR>", { desc = "Jump to the next request" })
keymap.set("n", "<leader>ki", "<cmd>lua require('kulala').inspect()<CR>", { desc = "Inspect the current request" })

-------------------------------- LSP mappings -----------------------------------
keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart LSP rename" })

------------------------------  Trouble mappings ------------------------------
keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
keymap.set(
	"n",
	"<leader>tT",
	"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
keymap.set("n", "<leader>tS", "<cmd>Trouble symbols toggle focus=false<CR>", { desc = "Symbols (Trouble)" })
keymap.set(
	"n",
	"<leader>tl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
keymap.set("n", "<leader>tL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
keymap.set("n", "<leader>tQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })

------------------------------ Lazy plugin manager mappings ------------------------------
keymap.set("n", "<leader>lz", "<cmd>Lazy<CR>", { desc = "Lazy Plugin Manager" })

------------------------------ Mason mappings ------------------------------
keymap.set("n", "<leader>ms", "<cmd>Mason<CR>", { desc = "Mason Config" })

----------------------- Snacks Keymaps ------------------------------
-- stylua: ignore start
keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
keymap.set("n", "<leader>nh", function() Snacks.picker.notifications() end, { desc = "Notification History" })
keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })

-- find
keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
keymap.set("n", "<leader>fx", function() Snacks.picker.todo_comments() end, { desc = "TODOs" })
keymap.set("n", "<leader>fX", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, { desc = "TODO/FIX/FIXMEs" })

-- Grep
keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
keymap.set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
keymap.set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })

-- search
keymap.set("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
keymap.set("n", "<leader>s/", function() Snacks.picker.search_history() end, { desc = "Search History" })
keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
-- Duplicate mapping for Buffer Lines (if intended)
keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
keymap.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
keymap.set("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "Search for Plugin Spec" })
keymap.set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- LSP
keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
keymap.set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
keymap.set({ "n", "v" }, "<leader>fm", "<cmd>lua require('conform').format({lsp_fallback = true, async = false, timeout_ms = 1000})<CR>", { desc = "Format file or range (in visual mode)" })

-- Other
keymap.set("n", "<leader>x", function() Snacks.bufdelete() end, { desc = "Buffer delete" })
keymap.set("n", "<leader>bD", function() Snacks.bufdelete.other() end, { desc = "Buffer delete others except current one" })
keymap.set("n", "<leader>z", function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
keymap.set("n", "<leader>Z", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
keymap.set("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })

-- Duplicate mapping for <leader>n (if intended)
keymap.set("n", "<leader>nh", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
keymap.set({ "n", "v" }, "<leader>gX", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
keymap.set("n", "<leader>lg", function() Snacks.lazygit() end, { desc = "Lazygit" })
keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
keymap.set("n", "<c-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
keymap.set("n", "<c-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })
keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
keymap.set("n", "<leader>N", function()
  Snacks.win({
    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = "yes",
      statuscolumn = " ",
      conceallevel = 3,
    },
  })
end, { desc = "Neovim News" })

keymap.set("n", "<leader>ld", function() Snacks.terminal("lazydocker") end, { desc = "Lazydocker" })
keymap.set("n", "<leader>k9", function() Snacks.terminal("k9s") end, { desc = "k9s" })
-- stylua: ignore end

------------------------------ Debugging (DAP) mappings ------------------------------------
keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "Continue" })
keymap.set("n", "<leader>di", "<cmd> DapStepInto <CR>", { desc = "Step into" })
keymap.set("n", "<leader>do", "<cmd> DapStepOut <CR>", { desc = "Step out" })
keymap.set("n", "<leader>ds", "<cmd> DapStepOver <CR>", { desc = "Step over" })
keymap.set("n", "<leader>df", "<cmd> lua require('dap').continue()<CR>", { desc = "Start a debugging session" })
keymap.set("n", "<leader>dq", "<cmd> DapTerminate <CR>", { desc = "Stop debugging" })
-- F keys
keymap.set("n", "<F9>", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle breakpoint" })
keymap.set("n", "<F5>", "<cmd> DapContinue <CR>", { desc = "Continue" })
keymap.set("n", "<F1>", "<cmd> DapStepInto <CR>", { desc = "Step into" })
keymap.set("n", "<F2>", "<cmd> DapStepOver <CR>", { desc = "Step over" })
keymap.set("n", "<F3>", "<cmd> DapStepOut <CR>", { desc = "Step out" })
keymap.set("n", "<F8>", "<cmd> DapTerminate <CR>", { desc = "Stop debugging" })

------------------------------- Nvim Jupyter mappings -----------------------------------
-- Add cells
keymap.set("n", "<leader>ja", "<cmd>JupyterAddCellBelow<CR>", { desc = "Add Jupyter cell below" })
keymap.set("n", "<leader>jA", "<cmd>JupyterAddCellAbove<CR>", { desc = "Add Jupyter cell above" })

-- Cell operations
keymap.set("n", "<leader>jd", "<cmd>JupyterRemoveCell<CR>", { desc = "Remove current Jupyter cell" })
keymap.set("n", "<leader>jm", "<cmd>JupyterMergeCellAbove<CR>", { desc = "Merge with cell above" })
keymap.set("n", "<leader>jM", "<cmd>JupyterMergeCellBelow<CR>", { desc = "Merge with cell below" })
keymap.set("n", "<leader>jt", "<cmd>JupyterConvertCellType<CR>", { desc = "Convert cell type (code/markdown)" })

------------------------------- Python REPL Mappings -------------------------------
-- stylua: ignore start
keymap.set("n", "<leader>rs", "<cmd>lua require('nvim-python-repl').send_statement_definition()<CR>", { desc = "Send semantic unit to REPL" })
keymap.set("v", "<leader>rv", "<cmd>lua require('nvim-python-repl').send_visual_to_repl()<CR>", { desc = "Send visual selection to REPL" })
keymap.set("n", "<leader>rb", "<cmd>lua require('nvim-python-repl').send_buffer_to_repl()<CR>", { desc = "Send entire buffer to REPL" })
keymap.set("n", "<leader>rt", "<cmd>lua require('nvim-python-repl').toggle_execute()<CR>", { desc = "Toggle auto-execute after send" })
keymap.set("n", "<leader>rl", "<cmd>lua require('nvim-python-repl').toggle_vertical()<CR>", { desc = "Toggle vertical/horizontal REPL split" })
keymap.set("n", "<leader>ro", "<cmd>lua require('nvim-python-repl').open_repl()<CR>", { desc = "Open REPL in split" })
keymap.set("n", "<leader>rc", "<cmd>lua require('nvim-python-repl').send_current_cell_to_repl()<CR>", { desc = "Send cell under cursor to REPL" })
-- stylua: ignore end
------------------------------- Yanky mappings -----------------------------------
keymap.set("n", "<leader>fp", "<cmd> YankyRingHistory <CR>", { desc = "Open Yank History" })

------------------------------- Neogen mappings ----------------------------------
-- stylua: ignore start
keymap.set("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>", { noremap = true, silent = true, desc = "Generate docs on function"})
keymap.set("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", { noremap = true, silent = true, desc = "Generate docs on a class"})

------------------------------- CodeCompanion mappings -----------------------------------
keymap.set("n", "<leader>cA", "<cmd>CodeCompanionActions<CR>", { desc = "Trigger Code Companion Actions", silent = true })
keymap.set("v", "<leader>cA", "<cmd>CodeCompanionActions<CR>", { desc = "Trigger Code Companion Actions in Visual Mode", silent = true })
keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle Code Companion Chat", silent = true })
keymap.set("v", "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle Code Companion Chat in Visual Mode", silent = true })
keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<CR>", { desc = "Add to Code Companion Chat", silent = true })

------------------------------ Quarto mappings ------------------------------
keymap.set("n", "<leader>qp", '<cmd>lua require("quarto").quartoPreview()<CR>', { silent = true, noremap = true, desc = "Preview Quarto document" })
-- stylua: ignore end

------------------------------- DOOING mappings -----------------------------------
keymap.set("n", "<leader>td", "<cmd>Dooing<CR>", { desc = "Toggle dooing todo app", silent = true })

------------------------------- SSH Conn Managear mappings -----------------------------------
keymap.set("n", "<leader>ct", "<cmd>ConnManager toggle<CR>", { desc = "Toggle SSH connection manager", silent = true })
