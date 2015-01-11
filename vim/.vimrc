so ${VIMRUNTIME}/syntax/syntax.vim

set wildmode=longest,list
set incsearch
set noswapfile

" allow switching of unsaved buffers
set hidden

set tags=~/go/project/src/tags

" don't include tags in basic completion
" set complete-=t
"
" don't show a preview when doing omni completion
" set completeopt=menu

set omnifunc=syntaxcomplete#Complete

" setlocal spell spelllang=en_us

set statusline=%<%f\ [%{&ff}]%y%m%r%=%-14.(%l,%c%)\ %P

syntax enable

hightlight StatusLine ctermfg=0 ctermbg=4
hightlight StatusLineNC ctermfg=0 ctermbg=7
hightlight VertSplit cterm=none
hightlight ErrorMsg ctermfg=7 ctermbg=6

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <Esc>n :tabnext<CR>
nnoremap <Esc>p :tabprevious<CR>

vnoremap  :w !runsnippet<CR>
nnoremap  ?```<CR>jjv/```<CR>k$:w !runsnippet<CR>

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
autocmd FileType html set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType lua set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd BufWritePre *.go Fmt

set autoindent

" strip tabs and trailing whitespace on save
" autocmd BufWritePre *.py,*.php retab
" autocmd BufWritePre * %s/\s\+$//e

" reread .vimrc when it is editted
" autocmd BufWritePost ~/.vimrc so ~/.vimrc

" http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits.html
" normalize navigation between vim and tmux splits
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
