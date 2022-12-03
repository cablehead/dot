require("plugins")

require("setup/formatter")

vim.api.nvim_set_keymap("", "<M-p>", [[<cmd>PackerSync<CR>]], {})

vim.api.nvim_set_keymap("n", "  ", [[<cmd>bprevious<CR>]], {})
vim.api.nvim_set_keymap("n", " ff", [[<cmd>lua require('fzf-lua').files()<CR>]], {})
vim.api.nvim_set_keymap("n", " fb", [[<cmd>Telescope buffers<CR>]], {})
vim.api.nvim_set_keymap("n", "\\b", [[<cmd>Telescope buffers<CR>]], {})
vim.api.nvim_set_keymap("n", " fc", [[<cmd>lua require('fzf-lua').command_history()<CR>]], {})
vim.api.nvim_set_keymap("n", " fo", [[<cmd>lua require('fzf-lua').oldfiles()<CR>]], {})

vim.api.nvim_set_keymap("n", " qr", [[<cmd>Reload<CR><cmd>echom "reloaded"<CR>]], {})
vim.api.nvim_set_keymap("n", " .f", [[<cmd>w<CR><cmd>Format<CR>]], {})
vim.api.nvim_set_keymap("n", " .F", [[<cmd>w<CR><cmd>FormatWrite<CR>]], {})

vim.cmd([[
set mouse=
set laststatus=0

highlight VertSplit cterm=none
set nohlsearch

" work around for blown out colors in telescope
" which may be from a regression in nvim
" # Broken color scheme
"   https://github.com/nvim-telescope/telescope.nvim/issues/2145
hi NormalFloat ctermfg=LightGrey

vnoremap < <gv
vnoremap > >gv

nnoremap <silent> <C-h> :lua require('tmux').move_left()<CR>
nnoremap <silent> <C-l> :lua require('tmux').move_right()<CR>
nnoremap <silent> <C-j> :lua require('tmux').move_down()<CR>
nnoremap <silent> <C-k> :lua require('tmux').move_up()<CR>

set statusline=%<%f                            " path to file
set statusline+=\ [%{&ff}]                     " space + fileformat
set statusline+=%y                             " filetype
set statusline+=%{&expandtab?'[spc]':'[TAB]'}  " is expandtab set?
set statusline+=%m                             " modified status
set statusline+=%r                             " read only flag
set statusline+=%=                             " switch to the right side
set statusline+=%-14.(%l,%c%)                  " current line,col
set statusline+=\ %L                           " total number of lines

" http://ricostacruz.com/til/repeat-tmux-from-vim.html
" run up enter in the last tmux pane used
function! s:TmuxRepeat()
    let x = system("tmux select-pane -l && tmux send up enter && tmux select-pane -l")
endfunction
noremap  <C-i> :w<CR>:call <SID>TmuxRepeat()<CR>
]])

local reload = require("nvim-reload")

-- If you use Neovim's built-in plugin system
-- Or a plugin manager that uses it (eg: packer.nvim)
local plugin_dirs = vim.fn.stdpath("data") .. "/site/pack/*/start/*"

-- If you use vim-plug
-- local plugin_dirs = vim.fn.stdpath('data') .. '/plugged/*'

reload.vim_reload_dirs = { vim.fn.stdpath("config"), plugin_dirs }

reload.lua_reload_dirs = {
    vim.fn.stdpath("config"),
    -- Note: the line below may cause issues reloading your config
    plugin_dirs,
}
