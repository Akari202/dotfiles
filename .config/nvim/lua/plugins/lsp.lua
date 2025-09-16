return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
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
                sync_install = true,
                auto_install = true,
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "markdown",
                    "markdown_inline",
                    "rust",
                    "latex",
                    "json",
                    "toml",
                    "wgsl",
                }
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
                accents = 0,
                ligatures = 0,
                cites = 0,
                fancy = 0,
                spacing = 0,
                greek = 0,
                math_bounds = 0,
                math_delimiters = 0,
                math_fracs = 0,
                math_super_sub = 0,
                math_symbols = 0,
                sections = 0,
                styles = 0
            }
        end
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup()
            vim.diagnostic.config({ virtual_text = false })
        end
    },
    {
        "stevearc/conform.nvim",
        opts = {}
    }
}
