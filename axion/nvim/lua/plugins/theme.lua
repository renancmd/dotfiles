-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function ()
--     vim.cmd[[colorscheme tokyonight-moon]]
--   end
-- }

return {
  "tiesen243/vercel.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("vercel").setup({
      theme = "dark",
      transparent = false,
    })
    vim.cmd.colorscheme("vercel")
  end,
}

-- return {
--   "Mofiqul/dracula.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--       require("dracula").setup({
--       transparent = false
--     })
--     vim.cmd.colorscheme("dracula")
--   end,
-- }

--   return {
--     -- add dracula
--     { "Mofiqul/dracula.nvim" },
--
--   -- Configure LazyVim to load dracula
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "dracula",
-- },
-- },
-- }

-- return  { 
--   "catppuccin/nvim",
--   name = "catppuccin", 
--   priority = 1000,
--   config = function()
--     vim.cmd("colorscheme catppuccin")
--   end
-- }

-- return {
-- "rose-pine/neovim",
-- name = "rose-pine",
-- config = function()
-- vim.cmd("colorscheme rose-pine")
-- end
-- }

