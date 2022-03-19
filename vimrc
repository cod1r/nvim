set relativenumber
set number
set ts=2 sw=2
set smartindent
set autoindent
set smartcase
call plug#begin('~/.vim/plugged')
	Plug 'leafgarland/typescript-vim'
	Plug 'peitalin/vim-jsx-typescript'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'arcticicestudio/nord-vim'
call plug#end()
colorscheme nord
