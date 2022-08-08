-- Indent Lines
vim.g.indentLine_char = '│'
vim.g.indentLine_fileTypeExclude = {'alpha'}

-- FIX make minimap and chad not fight for space
vim.g.minimap_auto_start = 0 
vim.g.minimap_width = 10

-- coq
vim.g.coq_settings = {
  auto_start = true
}

-- Chad
local chadtree_settings = {
    ['view.width'] = 30,
    ['view.window_options.wrap'] = true
}
vim.g.chadtree_settings = chadtree_settings
vim.cmd [[
    autocmd UIEnter * CHADopen
]]

-- Airline
vim.cmd [[
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline_powerline_fonts = 1
    let g:airline_section_c_only_filename = 1
]]

