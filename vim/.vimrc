so ${VIMRUNTIME}/syntax/syntax.vim

set wildmode=longest,list
set incsearch

" allow switching of unsaved buffers
set hidden

" don't include tags in basic completion
set complete-=t
set tags=~/lib/python2.4/site-packages/tags
" don't show a preview when doing omni completion
set completeopt=menu

" setlocal spell spelllang=en_us

set statusline=%<%f\ [%{&ff}]%y%m%r%=%-14.(%l,%c%)\ %P

" simplenote
source ~/.simplenote

" colorscheme ps_color
colorscheme ir_black
highlight Pmenu ctermbg=blue ctermfg=white
highlight Pmenusel ctermbg=green ctermfg=white
highlight Comment ctermfg=cyan
highlight String ctermfg=green

nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
nnoremap <C-j> :tabnext<CR>
nnoremap <C-k> :tabprevious<CR>

vnoremap < <gv
vnoremap > >gv

filetype plugin on
autocmd BufRead,BufNewFile *.tac setf python

" clear all matches
autocmd BufEnter * match
" match lines greater than 80 chars: /\%>80v.\+/
" match tabs: /^[[:tab:]]\+/
autocmd BufEnter *.py,*.php,*.tac  match Error /\%>80v.\+\|^[[:tab:]]\+/

autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType go set tabstop=4|set shiftwidth=4|set noexpandtab

set autoindent

" strip tabs and trailing whitespace on save
" autocmd BufWritePre *.py,*.php retab
" autocmd BufWritePre * %s/\s\+$//e

" reread .vimrc when it is editted
" autocmd BufWritePost ~/.vimrc so ~/.vimrc
