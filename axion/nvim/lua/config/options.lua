local opt = vim.opt

-- vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
-- vim.opt.termguicolors = false

-- 1. Re-enable true color for syntax highlighting
vim.opt.termguicolors = true

-- 2. Clear the background of all standard UI elements
local transparent_groups = {
    "Normal",       -- Main text background
    "NormalNC",     -- Non-current window background
    "LineNr",       -- Line numbers
    "FoldColumn",   -- Fold column
    "NonText",      -- Tildes at the end of the buffer
    "SignColumn",   -- Gutter where Git signs/diagnostics live
    "EndOfBuffer",  -- Empty lines at the end of a file
}

for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end

-- Lines
opt.number = true
opt.cursorline = true
opt.shiftwidth = 2
