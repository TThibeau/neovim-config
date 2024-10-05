print("Loading lua/tib/remap.lua")

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- Project View (open the explorer)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")  -- Use J in Visual mode to 'move the block down'
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")  -- Use K in Visual mode to 'move the block up'

vim.keymap.set("x", "<leader>p", "\"_dP")     -- Pasting without losing the original (allows pasting multiple times)

vim.keymap.set("n", "<leader>y", "\"+y")      -- Yank to OS clipboard (same as <CTRL-C>)
vim.keymap.set("v", "<leader>y", "\"+y")      -- Yank to OS clipboard in Visual mode
vim.keymap.set("n", "<leader>Y", "\"+Y")      -- Yank from here to end of line to OS clipboard (same as <CTRL-C>)

-- Replace Word (F2 does a similar thing but uses the LSP instead)
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
