local keymap = vim.keymap -- for conciseness

vim.g.mapleader = " "
vim.g.maplocalleader = ","

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
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--------------------  File operations -------------------
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "File Save" }) -- save current file
keymap.set("n", "<C-c>", "<cmd>%y+<CR>", { desc = "File Copy whole" }) -- copy the whole file to clipboard

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
keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close buffer" })
keymap.set("n", "<leader>bD", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all buffers except current" })
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
keymap.set("n", "<leader>bt", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

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
