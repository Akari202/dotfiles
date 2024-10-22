return {
    {
        "dracula/vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("dracula")
        end
    },
    {
        "ms-jpq/chadtree",
        config = function()
            vim.g.chadtree_settings = {
                ["view.width"] = 30,
                -- ["view.window_options.wrap"] = true,
                -- ["options.version_control"] = true
            }
        end,
        build = "python3 -m chadtree deps"
    },
    -- {
    --     "MysticalDevil/inlay-hints.nvim",
    --     event = "LspAttach",
    --     dependencies = {
    --         "neovim/nvim-lspconfig"
    --     },
    --     config = function()
    --         require("inlay-hints").setup()
    --     end
    -- },
    {
        "Yggdroot/indentLine",
        config = function()
            vim.g.indentLine_char = "│"
            vim.g.indentLine_fileTypeExclude = {"alpha", "CHADTree"}
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },
    {
        "vim-airline/vim-airline",
        -- lazy = false,
        init = function()
            vim.g.airline_theme = "dracula"
            vim.cmd([[
                let g:airline#extensions#tabline#enabled = 1
                let g:airline#extensions#tabline#formatter = "unique_tail"
                let g:airline_powerline_fonts = 1
                let g:airline_section_c_only_filename = 1
            ]])
        end
    },
    {
        "nvim-tree/nvim-web-devicons"
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    }
}