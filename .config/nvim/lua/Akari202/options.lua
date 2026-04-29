-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

-- File details
vim.opt.fixendofline = true
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 500

-- Wrapping
vim.opt.wrap = true
vim.opt.whichwrap = "b,s,<,>,[,]"

-- Search
vim.opt.ignorecase = true
vim.opt.hlsearch = true

-- Color
vim.opt.termguicolors = true
vim.o.background = "light"

-- Concealcursor is just awful
-- NOTE: for some reason i can't get this to work
vim.opt.concealcursor = ""
vim.opt.conceallevel = 1

-- Inlay hints
vim.lsp.inlay_hint.enable()

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- Computer specific config
local hostname = vim.uv.os_gethostname()
if (hostname == "thrawn" or hostname == "mac-hostname") and not vim.g.neovide then
	vim.opt.guifont = { "ComicCode Nerd Font" }
elseif hostname == "USMILPC434" then
	vim.opt.guifont = { "FiraCode Nerd Font Mono:h14:Regular" }
end

-- Disable and enable autoformat on save
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat on save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat on save",
})
