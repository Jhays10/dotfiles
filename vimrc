set nocompatible                    " full vim
syntax enable                       " enable syntax highlighting
set encoding=utf8                   " utf8 default encoding

call pathogen#infect()              " load pathogen
filetype plugin indent on

noremap , \
let mapleader = ","
runtime macros/matchit.vim

set scrolloff=3                     " show 3 lines of context around the cursor
set autoread                        " set to auto read when a file is changed from the outside
set autowrite
set showcmd                         " show typed commands

set wildmenu                        " turn on WiLd menu
set wildmode=list:longest,list:full " activate TAB auto-completion for file paths
set wildignore+=*.o,.git,.svn

set ruler                           " always show current position
set backspace=indent,eol,start      " set backspace config, backspace as normal

set hlsearch                        " highlight search things
set incsearch                       " go to search results as typing
set smartcase                       " but case-sensitive if expression contains a capital letter.
set ignorecase                      " ignore case when searching
set gdefault                        " assume global when searching or substituting
set magic                           " set magic on, for regular expressions
set showmatch                       " show matching brackets when text indicator is over them

set lazyredraw                      " don't redraw screen during macros, faster
set ttyfast                         " improves redrawing for newer computers
set fileformats=unix,mac,dos
set ttymouse=xterm

set nobackup                        " prevent backups of files, since using vcs
set nowritebackup
set noswapfile

set shiftwidth=2                    " set tab width
set softtabstop=2
set tabstop=2

set smarttab
set expandtab                       " use spaces, not tabs
set autoindent                      " set automatic code indentation
set hidden                          " allow background buffers w/out writing

set nowrap                          " don't wrap lines

set list                            " show hidden characters
set listchars=tab:\ \ ,trail:·      " show · for trailing space, \ \ for trailing tab
set spelllang=en,es                 " set spell check language
set noeb vb t_vb=                   " disable audio and visual bells

set t_Co=256                        " use 256 colors
colorscheme reallyshady " terminal theme
" colorscheme solarized
" set background=dark

if exists('+colorcolumn')
   set colorcolumn=72              " show a right margin column
endif
set cursorline                     " highlight current line
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=2\x7"

" FOLDING
set foldenable                     " enable folding
set foldmethod=indent              " most files are evenly indented
set foldlevel=99

" ADDITIONAL KEY MAPPINGS

" fast saving
nmap <leader>w :up<cr>

" fast escaping
imap jj <ESC>

" prevent accidental striking of F1 key
map <F1> <ESC>
imap <F1> <ESC>

" clear highlight
nnoremap <leader><space> :noh<cr>

" map Y to match C and D behavior
nnoremap Y y$

" yank entire file (global yank)
nmap gy ggVGy

" ignore lines when going up or down
nnoremap j gj
nnoremap k gk

" auto complete {} indent and position the cursor in the middle line
inoremap {<CR>  {<CR>}<Esc>O
inoremap (<CR>  (<CR>)<Esc>O
inoremap [<CR>  [<CR>]<Esc>O

" fast window switching
map <leader>, <C-W>w

" cycle between buffers
map <leader>. :b#<cr>

" change directory to current buffer
map <leader>cd :cd %:p:h<cr>

" open file explorer
set shortmess=at
map <silent> <leader>n :NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1

" swap implementations of ` and ' jump to prefer row and column jumping
nnoremap ' `
nnoremap ` '

" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv

" copy/paste to/from x clipboard
" vmap <leader>y :!xclip -f -sel clip<cr>
vmap <leader>y :w !pbcopy<cr><cr>
map <leader>p :r!pbpaste<cr><cr>
" nmap <F2> :.w !pbcopy<cr><cr>
"
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

" pull word under cursor into lhs of a substitute (for quick search and replace)
nmap <leader>r :%s#\<<C-r>=expand("<cword>")<CR>\>#

" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//e<cr>:let @/=''<CR>

" insert path of current file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" fast editing of the .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" allow saving when you forgot sudo
cmap w!! w !sudo tee % >/dev/null

" turn on spell checking
map <leader>spl :setlocal spell!<cr>

" spell checking shortcuts
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"" ADDITIONAL AUTOCOMMANDS

" saving when focus lost (after tabbing away or switching buffers)
au FocusLost,BufLeave,WinLeave,TabLeave * silent! up

" open in last edit place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
au QuickFixCmdPost *grep* cwindow

"" ABBREVIATIONS
source $HOME/.vim/autocorrect.vim

"" PLUGIN SETTINGS

let g:netrw_liststyle=3  " use tree style for netrw

" Unimpaired
" bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" CTRLP
map <leader>t :CtrlP<cr>
map <leader>b :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = '\v[\/](bower_components|node_modules)$'

" Powerline
let g:Powerline_symbols = 'fancy'
" let g:Powerline_theme='short'
" let g:Powerline_colorscheme='solarized256_dark'

" Ack
set grepprg=ack
nnoremap <leader>a :Ack<space>
let g:ackhighlight=1
let g:ackprg="ag --nocolor --nogroup --column --ignore node_modules --ignore bower_components"

" CoffeeScript
map <leader>cc :CoffeeCompile<cr>
map <silent> <leader>cm :CoffeeMake<cr> <cr>

" Git
map <leader>gs :Gstat<cr>
map <leader>gc :Gcommit<cr>

" Node
map <leader>rn :!node %<cr>

"" LANGUAGE SPECIFIC

" Python
au FileType python set noexpandtab

" Markdown
au FileType markdown set wrap

"" STATUS LINE
set laststatus=2 " always hide the last status
