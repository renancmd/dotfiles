local catppuccin = { 
  	"catppuccin/nvim",
  	name = "catppuccin", 
	priority = 1000,
  	config = function()
    	vim.cmd("colorscheme catppuccin")
  	end
}

local rose_pine = {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
	vim.cmd("colorscheme rose-pine")
	end
}

local dracula = {
  	"Mofiqul/dracula.nvim",
  	lazy = false,
  	priority = 1000,
  	config = function()
      	require("dracula").setup({
      	transparent = false
    	})
    	vim.cmd.colorscheme("dracula")
  	end,
}

local tokyodark = {
	"tiagovla/tokyodark.nvim",
    	opts = { },
    	config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        vim.cmd [[colorscheme tokyodark]]
    	end,
}

local tokyonight = {
  	"folke/tokyonight.nvim",
  	lazy = false,
  	priority = 1000,
  	opts = {},
}

return catppuccin
