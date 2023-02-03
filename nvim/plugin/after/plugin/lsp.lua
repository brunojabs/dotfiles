local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
	'tsserver',
	'rust_analyzer',
})

lsp.configure('svelte', {
  settings = {
		svelte= {
			['enable-ts-plugin'] = true
		}    
  }
})

local cmp = require('cmp')

-- Setup nvim-cmp.
local cmp = require'cmp'
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-d>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.close(),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
		end
	end, { "i", "s" }),

	["<Down>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
		end
	end, { "i", "s" }),

	["<S-Tab>"] = cmp.mapping(function()
		if cmp.visible() then
			cmp.select_prev_item()
		end
	end, { "i", "s" }),

	["<Up>"] = cmp.mapping(function()
		if cmp.visible() then
			cmp.select_prev_item()
		end
	end, { "i", "s" }),
})
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == "eslint" then
      vim.cmd.LspStop('eslint')
      return
  end

  local builtin = require('telescope.builtin')

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[e", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]e", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader><space>", vim.lsp.buf.code_action, opts)
  vim.keymap.set("v", "<leader><space>", vim.lsp.buf.range_code_action, opts)
  vim.keymap.set("n", "gh", builtin.lsp_references, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})


lsp.setup()
require("mason-lspconfig").setup {
    automatic_installation = false,
}
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
