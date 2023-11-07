-- Toggle tagbar
vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>')

-- Toggle chad
vim.keymap.set('n', '<F7>', ':CHADopen<CR>')

-- Toggle trouble
vim.keymap.set('n', '<F6>', ':TroubleToggle<CR>')

-- Open telescope
-- vim.keymap.set('n', '<F5>', ':Telescope<CR>')
-- vim.keymap.set('n', '<F4>', ':Telescope oldfiles<CR>')

-- Show alpha
vim.keymap.set('n', '<F1>', ':Alpha<CR>')

-- Open Cargo.toml
vim.keymap.set('n', '<F2>', ':RustOpenCargo<CR>')

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


