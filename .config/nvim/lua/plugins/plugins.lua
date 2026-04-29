return {
	{
		-- "rakr/vim-one",
		"laggardkernel/vim-one",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("one")
		end,
	},
	{
		"ms-jpq/chadtree",
		config = function()
			vim.g.chadtree_settings = {
				["view.width"] = 30,
				-- ["view.window_options.wrap"] = true,
				-- ["options.version_control"] = true,
			}
		end,
		build = "python3 -m chadtree deps",
	},
	{
		"Yggdroot/indentLine",
		config = function()
			vim.g.indentLine_char = "│"
			vim.g.indentLine_fileTypeExclude = { "CHADTree", "mason" }
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"vim-airline/vim-airline",
		-- lazy = false,
		init = function()
			vim.g.airline_theme = "one"
			vim.cmd([[
                let g:airline#extensions#tabline#enabled = 1
                let g:airline#extensions#tabline#formatter = "unique_tail"
                let g:airline_powerline_fonts = 1
                let g:airline_section_c_only_filename = 1
            ]])
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local Rule = require("nvim-autopairs.rule")
			local npairs = require("nvim-autopairs")
			npairs.setup({
				enable_check_bracket_line = true,
				-- map_cr = false,
			})
			npairs.add_rule(Rule("\\[", "\\]", { "tex", "latex" }))
			npairs.add_rule(Rule("$", "$", { "tex", "latex", "typst" }))
			npairs.add_rule(Rule("$ ", " $", { "typst" }))

			-- <CR> for both autopairs and coq completion
			-- doesnt work properly
			-- vim.keymap.set("i", "<CR>", function()
			-- 	if vim.fn.pumvisible() ~= 0 then
			-- 		if vim.fn.complete_info({ "selected" }).selected ~= 0 then
			-- 			return require("nvim-autopairs").esc("<c-y>")
			-- 		else
			-- 			return require("nvim-autopairs").esc("<c-e>") .. require("nvim-autopairs").autopairs_cr()
			-- 		end
			-- 	else
			-- 		return require("nvim-autopairs").autopairs_cr()
			-- 	end
			-- end, { expr = true, silent = true })
		end,
	},
	{
		"jbyuki/nabla.nvim",
	},
	{
		"mcauley-penney/visual-whitespace.nvim",
		event = "ModeChanged *:[vV\22]",
	},
	{
		"gbprod/substitute.nvim",
		config = function()
			require("substitute").setup()
			vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
			vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
			vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
			vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
		end,
	},
}
