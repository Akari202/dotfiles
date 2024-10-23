return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            {
                "ms-jpq/coq_nvim",
                branch = "coq",
                build = "python3 -m coq deps"
            },
            { "ms-jpq/coq.artifacts", branch = "artifacts" },
            { "ms-jpq/coq.thirdparty", branch = "3p" }
        },
        init = function()
            vim.g.coq_settings = {
                auto_start = true
            }
        end,
        config = function()
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
            local lspconfig = require("lspconfig")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                sync_install = false,
                auto_install = false,
                -- ensure_installed = {
                --     "c",
                --     "lua",
                --     "vim",
                --     "vimdoc",
                --     "query",
                --     "markdown",
                --     "markdown_inline",
                --     "rust",
                --     "latex",
                --     "json",
                --     "toml",
                --     "wgsl"
                -- }
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    },
    {
        "lervag/vimtex",
        lazy = false,
        -- tag = "v2.15",
        config = function()
            vim.g.vimtex_syntax_conceal = {
                accents = 1,
                ligatures = 0,
                cites = 1,
                fancy = 0,
                spacing = 1,
                greek = 1,
                math_bounds = 0,
                math_delimiters = 1,
                math_fracs = 1,
                math_super_sub = 1,
                math_symbols = 1,
                sections = 0,
                styles = 1
            }
        end
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false
    }
}
