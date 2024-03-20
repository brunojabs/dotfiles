require("bufferline").setup {
  options = {
    sort_by = 'id',
    max_name_length = 40,
    tab_size = 25,
    diagnotiscs = "nvim_lsp",
    separator_syle = "slant",
    truncate_names = false, -- whether or not tab names should be truncated
    themable = false,       -- allows highlight groups to be overriden i.e. sets highlights as default
  }
}
