set relativenumber
set number
set ts=2 sw=2
set smartindent
set autoindent
set smartcase
set mouse=a
" for terminals that emit SGR-styled mouse events. This option only exists in
" vim
"set ttymouse=sgr
call plug#begin('~/.config/nvim/plugged')
	Plug 'leafgarland/typescript-vim'
	Plug 'peitalin/vim-jsx-typescript'
	Plug 'tomasiser/vim-code-dark'
call plug#end()
color codedark
