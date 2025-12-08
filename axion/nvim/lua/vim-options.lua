vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.number = true

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>i", "gg=G", { noremap = true, silent = true})
vim.keymap.set('n', '<leader>1', '0', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>1', '0', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>2', '$l', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>2', '$l', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>3', 'gg', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>3', 'gg', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>4', 'G', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>4', 'G', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':qa<CR>')
vim.keymap.set('n', '<leader>ya', ':%y+<CR>')

vim.cmd('command! RunC !gcc % -o %:r && %:r')
vim.cmd('command! RunJava !javac % && java %')


