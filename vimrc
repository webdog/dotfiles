execute pathogen#infect()
syntax on
set nocompatible
filetype plugin on
filetype plugin indent on
autocmd vimenter * ++nested colorscheme gruvbox
set guifont:SpaceMono\ Nerd\ Font\ Mono:h24
let mapleader=','
let g:table_mode_corner='|'
set t_Co=256

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>
"nnoremap <S-l> :NERDTreeToggle `=icl`<CR><CR>
"let NERDTreeQuitOnOpen = 1
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1
set encoding=utf-8
let g:fern#renderer = "nerdfont"
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
set conceallevel=2
set guicursor+=a:blinkon0

