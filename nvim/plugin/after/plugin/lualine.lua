require('lualine').setup {
  options = {
    theme  = 'solarized',
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },

  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    }
  }
}
