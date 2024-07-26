require("brunojabs.set")
require("brunojabs.remap")
require("brunojabs.lazy")

vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    if vim.g.savesession then
      vim.api.nvim_command("mks!")
    end
  end
})
