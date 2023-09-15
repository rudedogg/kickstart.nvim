-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  'mbbill/undotree',
  { 'neovim/nvim-lspconfig' },
  {"folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
	  -- your configuration comes here
	  -- or leave it empty to use the default settings
	  -- refer to the configuration section below
  },
},

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'sindrets/diffview.nvim',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Projects
  'ahmedkhalf/project.nvim',

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- Other file types
  'ziglang/zig.vim',
  'tikhomirov/vim-glsl',

  {
    "LintaoAmons/scratch.nvim",
    event = 'VimEnter',
    -- tag = "v0.8.0" -- use tag for stability, or without this to have latest fixed and functions
  },

  -- Scrollbar
  'petertriho/nvim-scrollbar',
  'kevinhwang91/nvim-hlslens',
  -- 'wfxr/minimap.vim',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      -- { 'williamboman/mason.nvim', config = true },
      -- 'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Neogit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true,
    opts = {
      disable_insert_on_commit = false,
    },
  },

-- empty setup using defaults
   {"nvim-tree/nvim-tree.lua"},

  {"nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }},

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({'n', 'v'}, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Jump to next hunk"})
        vim.keymap.set({'n', 'v'}, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Jump to previous hunk"})
      end,
    },
  },

  { "folke/tokyonight.nvim", name = "tokyonight", priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
-- { "rafamadriz/neon", name = "Neon", priority = 1000,
--     config = function()
--       vim.cmd.colorscheme 'neon'
--       vim.g.neon_style = "dark"
--       vim.g.neon_italic_keyword = true
--       vim.g.neon_italic_function = true
--     end,
--   },
-- { "Abstract-IDE/Abstract-cs", name = "Abstract-cs", priority = 1000,
--     config = function()
--       vim.cmd.colorscheme 'abscs'
--     end,
--   },
-- { "catppuccin/nvim", name = "catppuccin", priority = 1000,
--     config = function()
--       vim.cmd.colorscheme 'catppuccin-mocha'
--     end,
--   },
  -- {
  --   'Mofiqul/dracula.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'dracula'
  --   end,
  -- },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})

local colors = require("tokyonight.colors").setup()

require("scrollbar").setup({
    handle = {
        color = colors.bg_highlight,
    },
    marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
    }
})
require('hlslens').setup()

vim.filetype.add {
  extension = {
    zon = "zig",
  }
}
-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
require("nvim-tree").setup()

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Close telescope rather than enter normal mode on <esc>
local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}

-- Load telescope extensions for file_browser and projects
require("telescope").load_extension "file_browser"
require("project_nvim").setup()
require('telescope').load_extension('projects')


-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  --ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'zig' },
  ensure_installed = { 'c', 'cpp', 'vimdoc', 'vim', 'zig' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
-- Mirror doom emacs
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Go to previous error message' })
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Go to next error message' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  zls = { filetypes = { 'zig', 'zir', 'zon'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
--
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--       filetypes = (servers[server_name] or {}).filetypes,
--     }
--   end
-- }

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- Undotree
-- if has("persistent_undo")
--    let target_path = expand('~/.undodir')
--
--     " create the directory and any parent directories
--     " if the location does not exist.
--     if !isdirectory(target_path)
--         call mkdir(target_path, "p", 0700)
--     endif
--
--     let &undodir=target_path
--     set undofile
-- endif
--

local lspconfig = require('lspconfig')
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require('completion').on_attach()
end
local servers = {'zls'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
  }
end

-- LSP
-- require('lspconfig').clangd.setup {}
require('lspconfig').zls.setup {}

-- Keybindings
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Move selected lines around with J/K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- No annoying macros, or ex mode
vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "Q", "<nop>")

-- Don't move cursor when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor centered when navigating search matches
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Don't overwrite clipboard with selection when pasting
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- Delete to system clipboard
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])


-- TODO: This needs mapped to something else
-- vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format)

-- undo
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
-- vim.keymap.set('n', '<leader>bu', vim.cmd.UndotreeToggle)

-- Comment with ctrl+/
-- vim.keymap.set('n', '<D-a>/', 'gc', { desc = 'Comment Selection' })
-- vim.keymap.set('v', '<D-a>/', 'gc', { desc = 'Comment Selection' })

-- Zig greps
vim.keymap.set('n', '<leader>z/', ':Telescope live_grep search_dirs={"~/Developer/zig-macos-x86_64-0.11.0/lib/std"}<CR>', { desc = '[/]Live std Grep'})
vim.keymap.set('n', '<leader>fv', ':Telescope live_grep search_dirs={"src/vulkan/"} type_filter=zig<CR>', { desc = '[/]Live vulkan Grep'})

-- Doom Emacs mirrors - Cycle to next buffer with gt
vim.keymap.set('n', 'gt', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', 'gT', ':bprev<CR>', { desc = 'Previous buffer' })

-- Set the proper error format before we run :make with Zig
vim.api.nvim_create_autocmd({"QuickFixCmdPre"}, {
  pattern = "make*", -- unfortunately you can't tell if zig build is used here
  callback = function() 
    -- Set correct error format stings. This gets us proper data in the quickfix list/table
    -- HACK: This should be handled at the Vim Compiler level I think
    -- TODO: Multiline error output (https://ziglang.org/documentation/master/#Doc-Comments)
    -- TODO: Multiline test output (https://ziglang.org/documentation/master/#Test-Failure)
    -- TODO note: output can be multiline too, see (https://ziglang.org/documentation/master/#toc-packed-struct)
    vim.opt_local.errorformat = "%f:%l:%c: %trror: %m" -- error:
    vim.opt_local.errorformat:append("%f:%l:%c: %tote: %m") -- note:
    vim.opt_local.errorformat:append("%f:%l:%c: 0x %m") -- runtime panic
    vim.opt_local.errorformat:append("%f:%l:%c: %m") -- test failure, runtime panic
  end,
})

-- Load the quickfix output from :make(zig build) into Neovim diagnostics
vim.api.nvim_create_autocmd({"QuickFixCmdPost"}, {
-- TODO: Consider using makeprg to have this run before :make, or do it properly in the vim compiler config
  pattern = "make*", -- unfortunately you can't tell if zig build is used here
  callback = function() 
    local namespace_id = vim.api.nvim_create_namespace("Zig Compiler")
    local current_buffer_id = vim.api.nvim_win_get_buf(0) -- Gets active buffer id for current window

    -- Load the valid items in the quickfix list as Neovim diagnostics 
    vim.diagnostic.set(namespace_id, current_buffer_id, vim.diagnostic.fromqflist(vim.fn.getqflist()))

    -- Show trouble if there are multiple errors
    local error_count = #vim.diagnostic.get(current_buffer_id, { severity = vim.diagnostic.severity.ERROR })
    if error_count > 1 then
      vim.cmd(":Trouble")
    elseif error_count == 0 then
      vim.cmd(":TroubleClose")
    end
  end,
})
-- Doom Emacs mirrors - Zig
vim.keymap.set('n', '<leader>pc', ' :make run<CR> ', { desc = '[P]roject [C]ompile' })
vim.keymap.set('n', '<leader>pb', ':make<CR>', { desc = '[P]roject [B]uild' })

vim.keymap.set('n', '<leader>zr', ':make run<CR>', { desc = '[Z]ig [R]un' })
vim.keymap.set('n', '<leader>zb', ':make<CR>', { desc = '[Z]ig [B]uild' })
vim.keymap.set('n', '<leader>zt', ':make test<CR>', { desc = '[Z]ig [T]est' })
vim.keymap.set('n', '<leader>zs', ':make run -Doptimize=ReleaseSafe<CR>', { desc = 'Release[S]afe' })
vim.keymap.set('n', '<leader>zf', ':make run -Doptimize=ReleaseFast<CR>', { desc = 'Release[F]ast' })
-- Doom Emacs mirrors - Find files / Grep
vim.keymap.set('n', '<leader>/', require('telescope.builtin').live_grep, { desc = '[/]Live Grep' })
vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, { desc = '[P]roject [F]iles' })
-- vim.keymap.set('n', '<leader>pt', ':TodoTelescope keywords=TODO<CR>', { desc = '[P]roject [T]odos' })
vim.keymap.set('n', '<leader>pt', ':TodoTelescope<CR>', { desc = '[P]roject [T]odos' })
-- Doom Emacs mirrors - Git
vim.keymap.set('n', '<leader>gs', require('neogit').open, { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gg', require('neogit').open, { desc = '[G]et [G]it' })
--vim.keymap.set('n', '<leader>bf', require('telescope._extensions.file_browser').file_browser, { desc = '[B]rowse [F]ile' })

vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind [B]uffer' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]ile' })

-- Buffer stuff
vim.keymap.set('n', '<leader>b/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[B]uffer [/]Live Grep' })
vim.keymap.set('n', '<leader>bs', require('telescope.builtin').lsp_document_symbols, { desc = '[B]uffer [S]ymbols' })
vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_document_symbols, { desc = '[G]oto [S]ymbol' })

vim.keymap.set('n', '<leader>bf', ':Telescope file_browser<CR>', { desc = '[B]rowse [F]ile' })
vim.keymap.set('n', '<leader>fB', ':Telescope file_browser<CR>', { desc = '[F]ile [B]rowser' })
-- Doom Emacs mirrors - Projects
vim.keymap.set('n', '<leader>pp', ':Telescope projects<CR>', { desc = '[P]ick [P]rojects' })
--vim.keymap.set('n', '<leader>pp', require('telescope').extensions.projects.projects{}, { desc = '[P]ick [P]roject' })

vim.keymap.set("n", "<leader>x", "<cmd>Scratch<cr>")
vim.keymap.set("n", "<leader>fx", "<cmd>ScratchOpen<cr>")

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
