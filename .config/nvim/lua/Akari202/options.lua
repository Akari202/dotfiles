vim.opt.fixendofline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 500
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true
vim.opt.whichwrap = "b,s,<,>,[,]"
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.lsp.inlay_hint.enable()

-- Highlight yanked text
vim.highlight.on_yank()

local hostname = vim.loop.os_gethostname()

if hostname == "thrawn" or hostname == "mac-hostname" then
	vim.opt.guifont = { "ComicCode Nerd Font" }
end
