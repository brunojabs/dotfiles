syntax enable
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'

Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-rails'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-endwise'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'isRuslan/vim-es6'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim'
Plugin 'neomake/neomake'
Plugin 'elixir-editors/vim-elixir'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
set background=light
colorscheme solarized

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
set mouse=a
"set ttymouse=xterm2
set autoindent

" Display line numbers on the left
set number

" Reload the file on changes
set autoread

set colorcolumn=100
set tabstop=2
set shiftwidth=2
" Enable light line
set laststatus=2

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
map <C-\> :NERDTreeToggle<CR>
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml,javascript,scss,sass setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=100
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?

  " Clojure
  autocmd FileType clojure setlocal colorcolumn=80
  autocmd FileType clojure map <Leader>t :!lein test<cr>
augroup END

map <C-t> <esc>:tabnew<CR>
set showcmd

" Mapping <tab> to change navigate on tabs
nmap <tab> :tabnext<CR>
" Mapping shift +  <tab> to go to the previous tab
nmap <S-tab> :tabprevious<CR>

map <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>
set linespace=4

" Ctrl-P Plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_cmd = 'CtrlPMixed'


" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

	let g:ackprg = 'ag --nogroup --nocolor --column'

	cnoreabbrev ag Ack
	cnoreabbrev aG Ack
	cnoreabbrev Ag Ack
	cnoreabbrev AG Ack
endif


" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
map <C-a> <Home>
map <C-e> <End>

set backspace=indent,eol,start " allow backspacing over everything in insert mode

set splitbelow
set splitright

" Splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let mapleader = ","

" easymotion
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

autocmd BufWritePre * :%s/\s\+$//e

let g:neomake_ruby_makers = ['rubocop', 'reek']
let g:neomake_scss_makers = ['scss_lint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_sml_enabled_makers = ['smlnj']
let g:neomake_html_tidy_ignore_errors = ['proprietary attribute "v-']

let g:neomake_error_sign = {'text': "✖"}
let g:neomake_warning_sign = {'text': ">>"}
let g:neomake_highlight_columns = 1
"
" Prettier linting errors
highlight NeomakeErrorSign ctermfg=124 cterm=bold
highlight NeomakeWarningSign ctermfg=31 cterm=bold

call neomake#configure#automake('w')

" It executes neomake every save of file
autocmd! BufWritePost * Neomake
set incsearch
set clipboard^=unnamed
