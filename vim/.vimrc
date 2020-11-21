so ${VIMRUNTIME}/syntax/syntax.vim

set wildmode=longest,list
set incsearch
set noswapfile
set autoindent

" allow switching of unsaved buffers
set hidden

" always show status bar
set laststatus=2

set modeline
set modelines=5

set omnifunc=syntaxcomplete#Complete

set statusline=%<%f                            " path to file
set statusline+=\ [%{&ff}]                     " space + fileformat
set statusline+=%y                             " filetype
set statusline+=%{&expandtab?'[spc]':'[TAB]'}  " is expandtab set?
set statusline+=%m                             " modified status
set statusline+=%r                             " read only flag
set statusline+=%=                             " switch to the right side
set statusline+=%-14.(%l,%c%)                  " current line,col
set statusline+=\ %L                           " total number of lines

syntax enable

highlight StatusLine cterm=none ctermfg=black ctermbg=lightblue
highlight StatusLineNC cterm=none ctermfg=black ctermbg=white
highlight VertSplit cterm=none
highlight ErrorMsg ctermfg=black ctermbg=cyan
highlight Error ctermfg=black ctermbg=cyan

nnoremap <C-n> :tabnext<CR>
nnoremap <C-p> :tabprevious<CR>

function! GoFMT()
    let view = winsaveview()
    exe '%!gofmt -s'
    call winrestview(view)
endfunction

nnoremap <leader>G :call GoFMT()<CR>

nnoremap <C-e> ?###<CR>jV/###<CR>k::w !python<CR>

vnoremap < <gv
vnoremap > >gv

filetype plugin on
autocmd BufRead,BufNewFile *.tac setf python

augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown|setlocal spell spelllang=en_us
augroup END

autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType go set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType nginx set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType ghmarkdown set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType html set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType lua set tabstop=2|set shiftwidth=2|set noexpandtab
" autocmd BufWritePre *.go Fmt


" clear all matches
autocmd BufEnter * match
" match lines greater than 80 chars: /\%>80v.\+/
" match tabs: /^[[:tab:]]\+/
" autocmd BufEnter *.py,*.php,*.tac  match Error /\%>80v.\+\|^[[:tab:]]\+/

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

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <C-w>o :ZoomToggle<CR>

" http://ricostacruz.com/til/repeat-tmux-from-vim.html
" run up enter in the last tmux pane used
function! s:TmuxRepeat()
    let x = system("tmux select-pane -l && tmux send up enter && tmux select-pane -l")
endfunction
noremap  <C-i> :w<CR>:call <SID>TmuxRepeat()<CR>
