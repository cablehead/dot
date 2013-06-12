" Vim color file
" Maintainer: Ruda Moura <ruda@logicial.org>
" Last Change: Fri Nov 24 23:17:35 BRST 2006

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
highlight clear Normal
set background&

" Remove all existing highlighting and set the defaults.
highlight clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "satori"

" Vim colors
highlight Normal     ctermfg=NONE    cterm=NONE
highlight Comment    ctermfg=Cyan    cterm=NONE
highlight Constant   ctermfg=Red     cterm=NONE
highlight Number     ctermfg=Red     cterm=NONE
highlight Identifier ctermfg=NONE    cterm=NONE
highlight Statement  ctermfg=NONE    cterm=Bold
highlight PreProc    ctermfg=Blue    cterm=NONE
highlight Type       ctermfg=Magenta cterm=NONE
highlight Special    ctermfg=Magenta cterm=NONE
highlight Function   ctermfg=Green   cterm=NONE

" Vim monochrome
highlight Normal     term=NONE
highlight Comment    term=NONE
highlight Constant   term=Underline
highlight Number     term=Underline
highlight Identifier term=NONE
highlight Statement  term=Bold
highlight PreProc    term=NONE
highlight Type       term=Bold
highlight Special    term=NONE

" GVim colors
highlight Normal     guifg=NONE     gui=NONE
highlight Comment    guifg=DarkCyan gui=NONE
highlight Constant   guifg=Red      gui=NONE
highlight Number     guifg=Red      gui=Bold
highlight Identifier guifg=NONE     gui=NONE
highlight Statement  guifg=NONE     gui=Bold
highlight PreProc    guifg=Blue     gui=NONE
highlight Type       guifg=Magenta  gui=NONE
highlight Special    guifg=Red      gui=Bold
