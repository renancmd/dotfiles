return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {

    python = { "ruff_format", "black" },

    javascript = { "prettier" },
    typescript = { "prettier" },

    lua = { "stylua" },

    c = { "clang_format" },
    cpp = { "clang_format" },

    java = { "google-java-format" },

    go = { "goimports", "gofmt" },

  }
  } 
}
