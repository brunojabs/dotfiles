vim.g.mapleader = ","

local hop = require("hop")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<tab>", vim.cmd.bn)
vim.keymap.set("n", "<S-tab>", vim.cmd.bp)
vim.keymap.set("n", "<leader>w", hop.hint_words) 
vim.keymap.set("n", "<leader>L", hop.hint_lines) 
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "n", "nzzzv")
