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
vim.opt.modelines = 0
-- taking away calling the manpages
vim.keymap.set({ 'n', 'v' }, '<S-k>', '<Nop>')

vim.cmd([[
call plug#begin('~/.config/nvim/plugged')
Plug 'tanvirtin/monokai.nvim'
call plug#end()
]])
require('monokai').setup {}
