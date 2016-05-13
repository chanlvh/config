set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Bundle 'mxw/vim-jsx'
Plugin 'ctrlpvim/ctrlp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


syntax on
set swapfile
set backupdir=~/.vim/backups,~/tmp,~/
set wildmenu
set ruler
set smartindent
set ignorecase
set smartcase
set hlsearch
set incsearch
filetype on
filetype plugin on
filetype indent on
au BufNewFile,BufRead Vagrantfile,Berksfile set filetype=ruby
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
set expandtab
set tabstop=2 "just add
set shiftwidth=2
set softtabstop=2
set pastetoggle=<F2>
set title
"set laststatus=2
"let g:user_zen_expandabbr_key = '<tab>'
"let g:user_zen_leader_key = '<tab>'

set clipboard=unnamed
let g:jsx_ext_required = 0

