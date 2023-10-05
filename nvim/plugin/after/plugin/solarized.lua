require("solarized").setup {
  theme = 'neo', 
  transparent = false,
  highlights = function(c, helper)
local lighten = helper.lighten

    return {
      Normal =  { fg = c.base0, bg = c.base04 },
      IndentBlanklineChar = { fg = lighten(c.base01, 50) },
      Visual = { standout = false }, -- Visual mode selection.
      VisualNOS = { link = 'Visual'},
      ColorColumn = { fg = c.base2 },
      -- Visual = {	fg= colors.bg, bg = lighten(colors.comment, 5)},
      -- Type = { fg = colors.yellow },
      -- Special = { fg = colors.yellow },
      Search = { fg = c.base2 , bg= c.yellow, fg = c.base03, reverse = false },
      IncSearch = { fg = c.base2, bg = c.yellow, standout = false },
      CurSearch = { link = 'IncSearch' },
      DiagnosticError = { link = 'Normal', underline = true }, -- Used as the base highlight group.(except Underline)
      -- DiffAdd = { fg = c.add, reverse = true },
      -- DiffChange = { fg = c.change, reverse = true }, -- Changed line
      -- DiffDelete  = { fg = c.delete, reverse = true }, -- Deleted line
      -- DiffText = { fg = c.blue, reverse = true } -- Changed Text
      -- ['@parameter'] = { fg = colors.content, bold = true, italic = true },
      -- ['@keyword'] = { fg = colors.content, bold = true },
      -- ['@keyword.function'] = { fg = colors.green },
  }
  end,
}
vim.o.termguicolors = true
vim.o.background = "light"
vim.opt.list = false 
vim.cmd("colorscheme solarized")

