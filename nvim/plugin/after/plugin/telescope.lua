local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.live_grep, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>D', builtin.diagnostics, {})
