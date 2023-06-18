local solarized = require("solarized")

solarized:setup {
  config = {
    theme = 'vscode', -- or 'neovim' or 'vscode'
    transparent = false 
  },
  colors = {
    red     = "#ff5555"
  },
  highlights = function(colors, darken, lighten, blend)
    return {
      Visual = {	fg= colors.bg, bg = lighten(colors.comment, 5)},
      Type = { fg = colors.yellow },
      -- Special = { fg = colors.yellow },
      -- Search = { bg= colors.yellow, fg= colors.bg},
      -- IncSearch = { bg = colors.yellow, fg = colors.bg },
      -- CurSearch = { link = 'IncSearch' },
      -- ['@parameter'] = { fg = colors.content, bold = true, italic = true },
      -- ['@keyword'] = { fg = colors.content, bold = true },
      -- ['@keyword.function'] = { fg = colors.green },
  }
  end,
}
vim.o.termguicolors = true
vim.o.background = "light"
vim.opt.list = true
vim.cmd("colorscheme solarized")

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = false,
}
