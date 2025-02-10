local keymap = vim.keymap -- for conciseness

vim.g.mapleader = " "

-------------------- General Keymaps -------------------
keymap.set("n", "<C-a>", "ggVG", { desc = "Select all text" })

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
keymap.set("t", "C-x", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

------------------------------ Bufferline mappings ------------------------------
keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close buffer" })
keymap.set("n", "<leader>bD", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all buffers except current" })
keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin buffer" })
keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
