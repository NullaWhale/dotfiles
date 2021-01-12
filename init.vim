set mouse=a
set number
set numberwidth=3
set relativenumber
set shiftwidth=4
set softtabstop=4
set shortmess=atI
set smarttab

set t_Co=256


call plug#begin('~/.local/share/nvim/plugged')
Plug 'w0ng/vim-hybrid'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'rust-lang/rust.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'racer-rust/vim-racer'
if has('nvim-0.5')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
end
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

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeChDirMode=2
let g:NERDTreeMapActivateNode = '<tab>'

" Tree-Sitter
if has('nvim-0.5')
lua << EOF
    require'nvim-treesitter.configs'.setup{
      ensure_installed = { "c", "cpp", "java", "go" },
      highlight = {
	enable = true
      }
    }
EOF
end

colorscheme hybrid
