vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.api.nvim_set_keymap("n", "<C-\\>", ":NvimTreeToggle<cr>" ,{silent = true, noremap = true})
require("nvim-tree").setup()
