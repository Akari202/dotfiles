-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

vim.cmd [[packadd packer.nvim]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end,
    },
})

-- FIX set order so that plugins that depend on eachother dont error
return require('packer').startup(function(use)
    -- Impatient to make loading faster
    use 'lewis6991/impatient.nvim'
    require 'impatient'

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'  
   
    -- Colorscheme
    use {
        'dracula/vim', 
        as = 'dracula'
    }

    -- Startup dashboard
    use {
        'goolord/alpha-nvim',
        config = function()
            require 'config.alpha'.setup()
        end
    }

    -- LSP, treesitter, autocomplete
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = 'all',
                sync_install = true,
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true
                }
            }
        end
    }
    use {
        'williamboman/mason.nvim',
        config = function()
            require 'mason'.setup {}
        end
    }
    use {
        'williamboman/mason-lspconfig.nvim',
       config = function()
            require('mason-lspconfig').setup {
                ensure_installed = { 
                    'clangd',
                    'cssls',
                    'gopls',
                    'groovyls',
                    'html',
                    'jsonls',
                    'jdtls',
                    'tsserver',
                    'kotlin_language_server',
                    'texlab',
                    'sumneko_lua',
                    'marksman',
                    'pylsp',
                    'solargraph',
                    'rust_analyzer',
                    'sqlls',
                    'taplo',
                    'lemminx',
                    'yamlls'
                }
            }
        end
    }
    use 'neovim/nvim-lspconfig' 
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'mfussenegger/nvim-dap'

    -- TODO look into cmp
    -- Coq
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq'
    }
    use {
        'ms-jpq/coq.artifacts',
        branch = 'artifacts'
    }
    use {
        'ms-jpq/coq.thirdparty',
        branch = '3p'
    }
    
    -- Auto pair brackes and stuff
    use {
        'windwp/nvim-autopairs',
        config = function()
            require 'nvim-autopairs'.setup {}
        end
    }

    -- Javap
    use 'udalov/javap-vim'

    -- File tree
    use {
        'ms-jpq/chadtree',
        branch = 'chad',
        run = 'python3 -m chadtree deps'
    }
    -- use {
    --     'kyazdani42/nvim-tree.lua',
    --     config = function()
    --         require 'nvim-tree'.setup {
    --             open_on_setup = true,
    --             rederer = {
    --                 trash = {
    --                     cmd = 'trash'
    --                 }
    --             }
    --         }
    --     end
    -- }

    -- Trouble
    use {
        'folke/trouble.nvim',
        config = function()
            require 'trouble'.setup {}
        end
    }

    -- Fancy icons
    use 'kyazdani42/nvim-web-devicons'
   
    -- Fast commenting
    use {
        'numToStr/Comment.nvim',
        config = function()
            require 'Comment'.setup {}
        end
    }

    -- FIX its not working for some reason
    -- Fancy todo
    use {
        'folke/todo-comments.nvim',
        config = function()
            require 'todo-comments'.setup {
                colors = {
                    error = {'DiagnosticError', 'ErrorMsg', '#ff5555'},
                    warning = {'DiagnosticWarning', 'WarningMsg', '#ffb86c'},
                    info = {'DiagnosticInfo', '#8be9fd'},
                    hint = {'DiagnosticHint', '#50fa7b'},
                    default = {'Identifier', '#bd93f9'}
                }
            }
        end
    }

    -- Minimap
    use 'wfxr/minimap.vim'
    
    -- Crate management
    use {
        'saecki/crates.nvim',
        event = {'BufRead Cargo.toml'},
        config = function()
            require('crates').setup()
        end
    }

    -- Tagbar
    use 'preservim/tagbar'

    -- TODO configure airline
    -- Airline statusbar
    use 'vim-airline/vim-airline'

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope-fzf-native.nvim', 
        run = 'make'
    }
    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            require 'telescope'.setup {}
            require 'telescope'.load_extension('fzf')
        end
    }

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require 'gitsigns'.setup {}
        end
    }

    -- Color highlighing
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup {
                '*';
            }
        end
    }
    
    -- CSV files
    use 'chrisbra/csv.vim'

    -- Indent lines
    use 'Yggdroot/indentLine'

    -- Discord rich presence
    use 'andweeb/presence.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
