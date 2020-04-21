set mouse=a
set shiftwidth=4
set softtabstop=4
set shortmess=atI
set smarttab

set t_Co=256


call plug#begin('~/.local/share/nvim/plugged')
Plug 'w0ng/vim-hybrid'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'rust-lang/rust.vim'
call plug#end()

" LightLine plugin
set noshowmode
let g:lightline = {
\ 'colorscheme': 'one',
\ 'active': {
\   'left':  [ [ 'mode', 'paste' ],
\	     [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
\   'right': [ [ 'lineinfo' ],
\	     [ ],
\	     [ 'fileformat', 'fileencoding', 'filetype' ] ]
\ },
\   'component_function': {
\	'gitbranch': 'fugitive#head'
\   },
\ }

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeChDirMode=2
let g:NERDTreeMapActivateNode = '<tab>'

colorscheme hybrid
