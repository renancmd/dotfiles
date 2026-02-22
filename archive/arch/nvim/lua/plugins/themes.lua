-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function ()
--     vim.cmd[[colorscheme tokyonight-moon]]
--   end
-- }

return {
    "tiagovla/tokyodark.nvim",
    opts = {
        -- custom options here
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        vim.cmd [[colorscheme tokyodark]]
    end,
}

-- return {
--   "tiesen243/vercel.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("vercel").setup({
--       theme = "light",
--       transparent = false,
--     })
--     vim.cmd.colorscheme("vercel")
--   end,
-- }

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

