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
		Plug 'MaxMEllon/vim-jsx-pretty'
		Plug 'neovim/nvim-lspconfig'
		Plug 'morhetz/gruvbox'
		Plug 'hrsh7th/cmp-nvim-lsp'
		Plug 'hrsh7th/nvim-cmp'
		Plug 'saadparwaiz1/cmp_luasnip'
		Plug 'L3MON4D3/LuaSnip'
	call plug#end()
	color gruvbox
]])
require('cmp').setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end
	},
	mapping = require('cmp').mapping.preset.insert({
		['<CR>'] = require('cmp').mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
  sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }
  }
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require('lspconfig').tsserver.setup{capabilities = capabilities}
require('lspconfig').gopls.setup{capabilities = capabilities}
require('lspconfig').ocamllsp.setup{capabilities = capabilities}
require('lspconfig').ccls.setup{
	capabilities = capabilities,
	init_options = {
		clang = {
			extraArgs = {"-std=c++20"}
		}
	}
}
vim.diagnostic.config({
	virtual_text = false
})
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.o.updatetime = 250
