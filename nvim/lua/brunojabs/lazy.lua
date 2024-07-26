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
          local darken = helper.darken

          return {
            Normal = { fg = c.base0, bg = c.base04 },
            NormalFloat = { fg = c.base0, bg = darken(c.base03, 5) },
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

      telescope.setup({
        extensions = {
          file_browser = {
            dir_icon = "",
            initial_mode = "normal"
          }
        }
      })

      require("telescope").load_extension('harpoon')
      require("telescope").load_extension("file_browser")

      vim.keymap.set('n', '<leader>pf', builtin.live_grep, {})
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>D', builtin.diagnostics, {})
      vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>pm', telescope.extensions.harpoon.marks, {})
      vim.keymap.set('n', '<leader>pt', function() builtin.grep_string({ search = "TODO(bruno)" }) end, {})
      vim.keymap.set('n', '<leader>pr', builtin.resume, {})
      vim.keymap.set("n", "<C-\\>", function()
        telescope.extensions.file_browser.file_browser()
      end)
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
        nextls = { enable = false },
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
          end,

        },
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
        }),
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

      local border = "rounded"

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = border
        }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = border
        }
      )

      require('luasnip.loaders.from_vscode').lazy_load()

      local lspconfig = require("lspconfig")
      lspconfig.tailwindcss.setup({
        root_dir = lspconfig.util.root_pattern(
          "mix.exs",
          "tailwind.config.js",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.ts",
          "package.json",
          "node_modules",
          ".git"
        ),
        init_options = {
          userLanguages = {
            elixir = "html-eex",
            eelixir = "html-eex",
            heex = "html-eex",
          },
        },
      })

      vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
    end
  },
  --lazy
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "mbbill/undotree",

    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  }
})
