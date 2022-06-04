vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ts = 2
vim.opt.sw = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smartcase = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.cmd([[
	call plug#begin('~/.config/nvim/plugged')
		Plug 'leafgarland/typescript-vim'
		Plug 'doums/darcula'
		Plug 'MaxMEllon/vim-jsx-pretty'
		Plug 'neovim/nvim-lspconfig'
	call plug#end()
	color darcula
]])
require('lspconfig').tsserver.setup{}
require('lspconfig').gopls.setup{}
require('lspconfig').ocamllsp.setup{}
vim.diagnostic.config({
	virtual_text = false
})
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.o.updatetime = 250
