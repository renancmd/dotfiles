return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Garante que ele compile os parsers na instalação
    event = { "BufReadPost", "BufNewFile" }, -- Carrega só quando abrir um arquivo (Lazy loading)
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        -- Instalar parsers essenciais automaticamente
        ensure_installed = { 
          "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "python" 
        },
        
        -- Instalar automaticamente se abrir um arquivo de linguagem nova
        auto_install = true,

        -- Habilitar o highlight (A parte mais importante)
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Habilitar indentação baseada em treesitter (experimental mas funciona bem)
        indent = { enable = true },
      })
    end,
  }
}
