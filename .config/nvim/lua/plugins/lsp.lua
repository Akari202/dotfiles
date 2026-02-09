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
				build = "python3 -m coq deps",
			},
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = "shut-up",
			}
		end,
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- "clangd",
					-- "pyrefly",
					"fortls",
					"lua_ls",
					"matlab_ls",
					"jsonls",
					"powershell_es",
					"stylua",
					"tombi",
					"wgsl_analyzer",
					"tinymist",
				},
			})
			vim.lsp.config("powershell_es", {
				init_options = { enableProfileLoading = false },
			})
			vim.lsp.config("tinymist", {
				cmd = { "tinymist" },
				filetypes = { "typst" },
				settings = {
					formatterMode = "typstyle",
					formatterPrintWidth = 100,
					formatterProseWrap = true,
					exportPdf = "never",
					semanticTokens = "enable",
				},
			})
			vim.lsp.enable("pyrefly")
			vim.lsp.enable("clangd")
		end,
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
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
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
				styles = 0,
			}
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						["rust-analyzer.cargo.features"] = { "all" },
					},
				},
			}
		end,
	},
	{
		"wassup05/fortran.nvim",
		lazy = true,
		ft = {
			"fortran",
		},
		opts = {
			formatter_opts = {
				enabled = false,
				path = "fprettify",
				format_on_save = false,
				args = {},
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					rust = { "rustfmt" },
					python = { "black", "usort" },
					toml = { "tombi" },
					json = { "jq" },
					lua = { "stylua" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					fortran = { "fprettify" },
					tex = { "tex-fmt" },
					go = { "gofmt" },
					bib = { "tex-fmt" },
					ron = { "fmtron" },
					matlab = { "mh_style" },
					["*"] = { "codespell" },
					["_"] = { "trim_whitespace", lsp_format = "last" },
				},
				default_format_opts = {
					lsp_format = "fallback",
				},
				format_on_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return {
						-- The python based formatters take a while to spinup
						timeout_ms = 2000,
					}
				end,
				log_level = vim.log.levels.DEBUG,
				formatters = {
					rustfmt = {
						options = {
							nightly = true,
							default_edition = "2024",
						},
					},
					fmtron = {
						append_args = { "-w", "80" },
					},
				},
				notify_no_formatters = true,
			})
		end,
	},
	{
		"TheLeoP/powershell.nvim",
		opts = {
			bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
		},
	},
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		opts = {},
	},
}
