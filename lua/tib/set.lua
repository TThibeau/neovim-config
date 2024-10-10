print("Loading lua/tib/set.lua")

vim.opt.nu = true             -- line numbers
vim.opt.relativenumber = true -- relative line numbers


-- Set vim indentation to a default of 4
-- (will be overwritten by format on save of LSP)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.wrap = false       -- Disable line wrapping

vim.opt.hlsearch = false   -- Don't keep highlighting the search term
vim.opt.incsearch = true   -- Incremental search

vim.opt.scrolloff = 999    -- Keep the cursor in the middle of the screen vertically

vim.opt.updatetime = 50    -- Fast updatetime

vim.opt.colorcolumn = "80" -- Creates a visual vertical line at 80 characters
