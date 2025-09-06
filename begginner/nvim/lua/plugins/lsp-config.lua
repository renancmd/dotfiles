return {
  -- Mason (gerenciador de servidores LSP/DAP/formatters)
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Integra Mason com LSPConfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",   -- JavaScript / TypeScript
          "pyright",    -- Python
          "lua_ls",     -- Lua
          "jdtls",      -- Java
          "clangd",     -- C / C++
          "omnisharp",  -- C#
        },
      })

      -- Função para keymaps LSP
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<C-q>", vim.diagnostic.setqflist, {})
        vim.keymap.set("n", "<C-w>", ":cclose<CR>", {})

      end

      -- Capabilities (melhora autocomplete quando usar nvim-cmp)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configurar servidores
      local lspconfig = require("lspconfig")
      local servers = { "ts_ls", "pyright", "lua_ls", "jdtls", "clangd", "omnisharp" }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
}

