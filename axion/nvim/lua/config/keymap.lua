vim.g.mapleader = " "
local map = vim.keymap.set

-- Leader key (space)

-- Moves
map({ "n", "v" }, "<leader>1", "0", { desc = "Go to the beggining of the line" })
map({ "n", "v" }, "<leader>2", "$l", { desc = "Go to the ending of the line" })
map({ "n", "v" }, "<leader>3", "gg", { desc = "Go to the first line" })
map({ "n", "v" }, "<leader>4", "G", { desc = "Go to the last line" })

-- Modes
map("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Neovim window
map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save files" })
map("n", "<leader>q", "<cmd>qa<cr><esc>", { desc = "Exit of neovim" })

-- File content
map("n", "<leader>h", "<cmd>noh<cr>", { desc = "Clean highlight search" })
map("n", "<leader>ciq", 'ci"', { desc = "Clear the current double quotes" })
map("n", "<leader>ciq", "ci'", { desc = "Clear the current quotes" })

map("n", "<leader>ya", ":%y+<CR>", { desc = "Copy all file content to the clipboard" })
map("n", "<leader>yl", '"+yy', { desc = "Copy the current line to the clipboard" })
map("v", "<leader>y", '"+y', { desc = "Copy the selected content to the clipboard" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection to down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Movo selection to up" })

map("n", "<leader>i", function()
	require("conform").format({
		lsp_fallback = true,
	})
end, { desc = "Format buffer" })

-- PLUGINS --

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>e", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>r", builtin.live_grep, { desc = "Telescope live grep" })

-- Neo Tree
map(
	"n",
	"<leader>o",
	":Neotree source=filesystem reveal=true position=right<cr>",
	{ desc = "Open the project filesystem on right side" }
)
map("n", "<leader>p", ":Neotree action=close<cr>", { desc = "Close the project filesystem" })

-- Trouble
map("n", "<leader>t", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Open trouble diagnostics" })

-- BarBar
map('n', '<A-w>', '<Cmd>BufferClose<CR>', { desc = "Close a tab" })
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
map('n', '<A-0>', '<Cmd>BufferLast<CR>')


-- Formatter
map('n', '<leader>f', vim.lsp.buf.format, { desc = "Formatar arquivo com LSP" })
