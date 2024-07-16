local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- SET
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

vim.g['test#neovim#term_position'] = "vert"
vim.g['test#strategy'] = "neovim"

require("lazy").setup({
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    opts = {}
  },
  'j-hui/fidget.nvim',
  { 'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons', opts = {} },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.api.nvim_set_keymap("n", "<C-\\>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
      require("nvim-tree").setup()
    end
  },
  { 'rust-lang/rust.vim' },
  {
    "ThePrimeagen/harpoon",
    config = function()
      local harpoon_mark = require("harpoon.mark")
      local harpoon_ui = require("harpoon.ui")

      vim.keymap.set('n', '<leader>m', harpoon_mark.add_file, {})
      vim.keymap.set('n', '<leader>ph', harpoon_ui.toggle_quick_menu, {})
      vim.keymap.set('n', '<M-0>', harpoon_ui.nav_next, {})
      vim.keymap.set('n', '<M-9>', harpoon_ui.nav_prev, {})
      vim.keymap.set("n", "<M-1>", function() harpoon_ui.nav_file(1) end)
      vim.keymap.set("n", "<M-2>", function() harpoon_ui.nav_file(2) end)
      vim.keymap.set("n", "<M-3>", function() harpoon_ui.nav_file(3) end)
      vim.keymap.set("n", "<M-4>", function() harpoon_ui.nav_file(4) end)
      vim.keymap.set("n", "<M-5>", function() harpoon_ui.nav_file(5) end)

      vim.keymap.set("n", "<M-6>", function() harpoon_ui.nav_file(6) end)
      vim.keymap.set("n", "<M-7>", function() harpoon_ui.nav_file(7) end)
      vim.keymap.set("n", "<M-8>", function() harpoon_ui.nav_file(8) end)
    end
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    opts = {}
  },
  {
    'stevearc/dressing.nvim',
    opts = {}
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk)
        map('n', '<leader>hr', gs.reset_hunk)
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end)
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    },
  },
  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.o.background = "light"
      vim.opt.list = false

      local opts = {
        theme = 'neo',
        transparent = true,
        highlights = function(c, helper)
          local lighten = helper.lighten

          c.base03 = '#fcf2d8';

          return {
            Normal = { fg = c.base0, bg = c.base04 },
            Visual = { standout = false }, -- Visual mode selection.
            VisualNOS = { link = 'Visual' },
            MatchParen = { bg = lighten(c.magenta, 50), fg = c.base03 },
            ['@parameter'] = { fg = c.magenta, italic = true, bold = true },
            ['@lsp.type.parameter'] = { fg = c.base0, bold = true }
          }
        end,
      }

      require('solarized').setup(opts)

      vim.cmd("colorscheme solarized")
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim', 'ThePrimeagen/harpoon' } },
    config = function()
      local builtin = require('telescope.builtin')
      local telescope = require('telescope')

      require("telescope").load_extension('harpoon')

      vim.keymap.set('n', '<leader>pf', builtin.live_grep, {})
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>D', builtin.diagnostics, {})
      vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>pm', telescope.extensions.harpoon.marks, {})
      vim.keymap.set('n', '<leader>pt', function() builtin.grep_string({ search = "TODO(bruno)" }) end, {})
      vim.keymap.set('n', '<leader>pr', builtin.resume, {})
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "javascript", "lua", "rust", "vim", "typescript" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          additional_vim_regex_highlighting = { "markdown" },
          disable = { "gitcommit" }
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
          },
        },
      }
    end
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        nextls = { enable = true },
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
        projectionist = {
          enable = true
        }
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-cmdline' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },

    config = function()
      -- Setup nvim-cmp.
      local cmp = require('cmp')

      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      require("fidget").setup({})
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "rust_analyzer",
          "tsserver",
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities
            }
          end
        }
      }

      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
        })
      })
      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      require('luasnip.loaders.from_vscode').lazy_load()

      vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
    end
  },
})

-- REMAP
local hop = require("hop")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<tab>", vim.cmd.bn)
vim.keymap.set("n", "<S-tab>", vim.cmd.bp)
vim.keymap.set("n", "<leader>w", hop.hint_words)
vim.keymap.set("n", "<leader>L", hop.hint_lines)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>bd", ":bd<CR>")
vim.keymap.set("n", "<leader>bD", ":bd!<CR>")
vim.keymap.set("n", "<M-q>", ":bd<CR>")
vim.keymap.set("n", "<leader>c", ":Cargo c<CR>")
vim.keymap.set("n", "<leader>C", ":Cargo clippy<CR>")
vim.keymap.set("n", "<leader>t", ":TestFile<CR>")
vim.keymap.set("n", "<leader>T", ":TestFile -strategy=neovim_sticky<CR>")

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    local builtin = require('telescope.builtin')
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[e", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]e", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader><space>", vim.lsp.buf.code_action, opts)
    vim.keymap.set("v", "<leader><space>", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gh", builtin.lsp_references, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  end
})
