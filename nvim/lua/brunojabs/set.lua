vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.laststatus = 2

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

vim.opt.nu = true
vim.opt.autoread = true
vim.opt.ignorecase = true

vim.opt.showcmd = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.g.netrw_banner = 1
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_winsize = 30

vim.cmd [[
augroup
  autocmd!
  autocmd FileType netrw setlocal bufhidden=wipe
augroup end
]]

vim.g['test#neovim#term_position'] = "vert"
vim.g['test#strategy'] = "neovim"
