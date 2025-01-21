-- Toggle chad
vim.keymap.set('n', '<F7>', ':CHADopen<CR>')

-- Disable Arrow Keys
vim.keymap.set('n', '<Left>', ':echoe "Use h"<CR>')
vim.keymap.set('n', '<Right>', ':echoe "Use l"<CR>')
vim.keymap.set('n', '<Up>', ':echoe "Use k"<CR>')
vim.keymap.set('n', '<Down>', ':echoe "Use j"<CR>')
-- vim.cmd([[
--     nnoremap <Left>  :echoe "Use h"<CR>
--     nnoremap <Right> :echoe "Use l"<CR>
--     nnoremap <Up>    :echoe "Use k"<CR>
--     nnoremap <Down>  :echoe "Use j"<CR>
--     inoremap <Left>  <ESC>:echoe "Use h"<CR>
--     inoremap <Right> <ESC>:echoe "Use l"<CR>
--     inoremap <Up>    <ESC>:echoe "Use k"<CR>
--     inoremap <Down>  <ESC>:echoe "Use j"<CR>
-- ]])

-- Reverse use of gj and gk with j and k
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'gj', 'j')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'gk', 'k')

vim.cmd([[
    nnoremap <leader>p :lua require("nabla").popup()<CR>
]])


