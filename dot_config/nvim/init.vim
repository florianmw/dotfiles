
call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'gilligan/vim-lldb'
Plug 'benekastah/neomake'
Plug 'vim-utils/vim-man'
Plug 'vim-utils/vim-cscope'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ervandew/supertab'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'
call plug#end()

syntax on
color synic

if has("gui_running")
  set guifont=Monaco
  set lines=45 columns=160
endif

"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
"set ruler

set laststatus=2

set listchars=eol:¶,tab:→.,trail:·,extends:>,precedes:<
"set listchars=tab:→,trail:·,eol:¶

set tabstop=8 shiftwidth=2 softtabstop=2 expandtab
set smartindent

"set mouse=a             " hold shift to copy xterm (default in neovim)
"set ttymouse=xterm2     " necessary for gnu screen & mouse (removed in neovim)

"set backspace=indent,eol,start "(default in neovim)

set title

set tags+=~/vos.tags

set nobackup
set nowritebackup

set viminfo='20,<1000,s10,h

set tabpagemax=100

set colorcolumn=80
highlight ColorColumn cterm=NONE ctermbg=234 guibg=Grey11

set cursorline " highlight the current line
highlight CursorLine cterm=NONE ctermbg=234 guibg=Grey11

"set foldcolumn=1
"highlight FoldColumn ctermbg=bg guifg=bg
"highlight FoldColumn ctermbg=234 guifg=Grey11
"highlight Folded ctermbg=234 guifg=Grey11

"set cursorcolumn
set hlsearch incsearch ignorecase smartcase
"highlight Search cterm=inverse
highlight Search cterm=NONE ctermbg=darkyellow ctermfg=yellow guibg=darkyellow guifg=yellow
highlight Visual cterm=NONE ctermbg=237 ctermfg=NONE guibg=Grey23

highlight DoubleClick ctermbg=242 guibg=Grey42

" vimdiff color scheme
"highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
highlight DiffAdd    cterm=none ctermbg=darkgreen guibg=darkgreen
highlight DiffDelete cterm=none ctermbg=darkred guibg=darkred
highlight DiffChange cterm=none ctermbg=darkyellow guibg=darkyellow
highlight DiffText   cterm=bold ctermbg=none gui=none

set scrolloff=5

" tabs for makefiles and .gitconfig
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType gitconfig setlocal noexpandtab shiftwidth=8 softtabstop=0

"highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
"match OverLength /\%81v.\+/

let g:NERDTreeWinPos = "right"

set titlestring=vim\ <%f>%(\ %M%)
set titleold=""

if &term =~ "screen.*"
  set t_ts=k
  set t_fs=\
  set title
endif

"nnoremap <silent> <2-leftMouse> :exe 'match DoubleClick /\V\<'.escape(expand('<cword>'), '\').'\>/'<cr>
nnoremap <silent> <2-leftMouse> :call HighlightWord()<cr>

" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

function HighlightWord ()
  if !exists ('b:lastWord')
    let b:lastWord = ''
  endif
  let currWord = escape (expand ('<cword>'), '\')
  if currWord == b:lastWord
    match none
    let b:lastWord = ''
    echo 'match none'
  else
    exec 'match DoubleClick /\V\<' . currWord . '\>/'
    let b:lastWord = currWord
    echo 'match '.currWord
  endif
endfunction

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

"set timeoutlen=50

" airline config

"let g:airline#extensions#tabline#enabled = 1

let g:airline_theme='ubaryd'
" powerline font
"let g:airline_powerline_fonts = 1
"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

