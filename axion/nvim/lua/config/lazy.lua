-- Lazy installation path
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- If not exist, clone the lazy rep
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- última versão estável
    lazypath,
  })
end

-- Vim runtimepath
vim.opt.rtp:prepend(lazypath)

-- Setup lazy and say where are the plugins
require("lazy").setup("plugins")
