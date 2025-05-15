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

