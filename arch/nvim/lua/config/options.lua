local opt = vim.opt

-- Lines
opt.relativenumber = false
opt.number = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2        -- 2 espaços para indentação
opt.expandtab = true      -- Converte tab em espaços
opt.autoindent = true

-- Área de transferência
opt.clipboard = "unnamedplus" -- Usa o clipboard do sistema (precisa do wl-clipboard no Hyprland)

-- Comportamento
opt.ignorecase = true     -- Busca ignorando maiúsculas/minúsculas
opt.smartcase = true      -- ...a menos que você digite uma maiúscula
opt.cursorline = true     -- Destaca a linha atual
opt.termguicolors = true  -- Cores reais de 24-bit
