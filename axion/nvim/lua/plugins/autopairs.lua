return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- só carrega quando você entra no modo insert
  config = function()
    require("nvim-autopairs").setup {}
  end,
}

