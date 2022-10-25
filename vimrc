execute pathogen#infect()
" Use homebrew's clangd
let g:ycm_clangd_binary_path = trim(system('brew --prefix llvm')).'/bin/clangd'
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
source /Users/webdog/github/ycm-core/lsp-examples/vimrc.generated
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
syntax on
set nocompatible
filetype plugin indent on
set expandtab
set ignorecase
set number
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set backspace=indent,eol,start
autocmd vimenter * ++nested colorscheme gruvbox
set guifont:SpaceMono\ Nerd\ Font\ Mono:h24
set bg=dark
let icl = "/Users/webdog/vim"
let mapleader=','
let imapleader=','
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
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-h> <Left>
inoremap <c-l> <Right>
nnoremap <S-h> :call ToggleHiddenAll()<CR>
"nnoremap <S-l> :NERDTreeToggle `=icl`<CR><CR>
"let NERDTreeQuitOnOpen = 1
"let NERDTreeMinimalUI = 1
"nnoremap <C-t> :Fern . -drawer -toggle<CR>
set encoding=utf-8
let g:fern#renderer = "nerdfont"
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
set conceallevel=2
set guicursor+=a:blinkon0
nnoremap <silent> <C-t> :Fern . -drawer -toggle -width=35<CR><C-w>=
