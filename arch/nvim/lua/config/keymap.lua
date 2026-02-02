local map = vim.keymap.set

-- Leader key (space)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Shortcuts
-- Moves
map({"n", "v"}, '<leader>1', '0', { desc = "Go to the beggining of the line" })
map({"n", "v"}, '<leader>2', '$l', { desc = "Go to the ending of the line" })
map({"n", "v"}, '<leader>3', 'gg', { desc = "Go to the first line" })
map({"n", "v"}, '<leader>4', 'G', { desc = "Go to the last line" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to the left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to the window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to the window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to the right window" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection to down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Movo selection to up" })
map("n", "<leader>a", "gg<S-v>G", { desc = "Select all" })

-- Modes and Commands
map({"i", "v"}, "jk", "<Esc>", { desc = "Leave from insert mode" } )
map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save files" })
map("n", "<leader>q", "<cmd>qa<cr><esc>", { desc = "Exit of neovim" } )
map("n", "<leader>h", "<cmd>noh<cr>", { desc = "Clean highlight search" })
map("n", "<leader>ciq", "ci\"", { desc = "Clear the current double quotes" } )
map("n", "<leader>ciq", "ci'", { desc = "Clear the current quotes" } )
map("n", "<leader>ya", ":%y+<CR>")
