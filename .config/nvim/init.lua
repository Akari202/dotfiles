-- Turn off ALE's lsp client to interface with coc.nvim
--vim.api.nvim_set_var('ale_disable_lsp', 1)

-- TODO: Migrate to packer from vim-plug
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- Copilot is terrifying
-- Plug('github/copilot.vim')

Plug('glacambre/firenvim')
Plug('udalov/javap-vim')
Plug('dracula/vim', {as = 'dracula'})
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']})
Plug('nvim-treesitter/playground')
Plug('nvim-treesitter/nvim-treesitter-context')
Plug('neovim/nvim-lspconfig')
Plug('mfussenegger/nvim-dap')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('ms-jpq/coq_nvim', {branch = 'coq'})
Plug('ms-jpq/coq.artifacts', {branch = 'artifacts'})
Plug('ms-jpq/coq.thirdparty', {branch = '3p'})
Plug('ms-jpq/chadtree', {branch = 'chad', ['do'] = vim.fn['python3 -m chadtree deps']})
Plug('ryanoasis/vim-devicons')
Plug('Yggdroot/indentLine')
Plug('wfxr/minimap.vim')
Plug('tpope/vim-surround') 
--Plug('sheerun/vim-polyglot')
Plug('vim-airline/vim-airline')
Plug('vimsence/vimsence')
Plug('jiangmiao/auto-pairs')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('preservim/tagbar')

vim.call('plug#end')

-- Configure indent lines
vim.g.indentLine_char = '│' 

-- Configure CHAD
local chadtree_settings = {
  ['view.width'] = 30,
  ['view.window_options.wrap'] = true
}
vim.g.chadtree_settings = chadtree_settings

-- Configure tagbar
vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>')

-- Configure LSP, treesitter and autocomplete
--vim.api.nvim_set_var('ale_sign_column_always', 1)
--vim.api.nvim_set_var('airline#extensions#ale#enabled', 1)
--vim.api.nvim_set_var('ale_lint_delay', 500)
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'all',
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
}
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 
    'vim-language-server', 
    'html-lsp', 
    'kotlin-language-server', 
    'json-lsp', 
    'clangd',
    'ltex-ls',
    'css-lsp',
    'python-lsp-server', 
    'rust-analyzer',
    'lua-language-server' 
  }
})
vim.g.coq_settings = {
  auto_start = true
}

-- Configure minimap
vim.g.minimap_auto_start = 1 
vim.g.minimap_width = 10

-- Configure airline


-- Configure colorscheme
vim.cmd [[
  if (has('termguicolors'))
    set termguicolors
  endif
  colorscheme dracula
]]
vim.g.airline_theme = 'dracula'

-- Configure neovim
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 500
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.expandtab = true
vim.opt.tabstop =  4

