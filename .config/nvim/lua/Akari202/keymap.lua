-- Leader
vim.g.mapleader = "'"
vim.g.maplocalleader = "\\"

-- Toggle chad
vim.keymap.set("n", "<F7>", ":CHADopen<CR>")

-- Disable Arrow Keys
vim.keymap.set("n", "<Left>", ':echoe "Use h"<CR>')
vim.keymap.set("n", "<Right>", ':echoe "Use l"<CR>')
vim.keymap.set("n", "<Up>", ':echoe "Use k"<CR>')
vim.keymap.set("n", "<Down>", ':echoe "Use j"<CR>')

-- Reverse use of gj and gk with j and k
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gk", "k")

-- Keep cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Clear highlights
vim.keymap.set("n", "<leader>h", "<cmd>noh<CR>")

-- Stay in visual mode while indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Put clipboard on a new line
vim.keymap.set("n", "<leader>P", "<cmd>put +<CR>")
vim.keymap.set("n", "<leader>O", "<cmd>put! +<CR>")

-- Go to definition
vim.keymap.set("n", "gd", vim.lsp.buf.definition)

-- Open nabla math preview
vim.keymap.set("n", "<leader>p", function()
	require("nabla").popup()
end)

-- Jump to next and previous errors (use ]d and [d for all diagnostics)
vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end)
