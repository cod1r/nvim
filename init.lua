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
vim.opt.autoread = true
vim.cmd([[
	call plug#begin('~/.config/nvim/plugged')
		Plug 'leafgarland/typescript-vim'
		Plug 'MaxMEllon/vim-jsx-pretty'
		Plug 'neovim/nvim-lspconfig'
		Plug 'hrsh7th/cmp-nvim-lsp'
		Plug 'hrsh7th/nvim-cmp'
		Plug 'saadparwaiz1/cmp_luasnip'
		Plug 'L3MON4D3/LuaSnip'
		Plug 'ziglang/zig.vim'
		Plug 'catppuccin/nvim', {'as': 'catppuccin'}
	call plug#end()
	color catppuccin
	let g:zig_fmt_autosave = 0
]])
local root_pattern = require('lspconfig').util.root_pattern
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

require('lspconfig').denols.setup{
	root_dir = root_pattern("deno.json", "deno.jsonc")
}
require('lspconfig').tsserver.setup{
	capabilities = capabilities,
	root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json")
}
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
require('lspconfig').hls.setup {capabilities = capabilities}
require'lspconfig'.rust_analyzer.setup{
	capabilities = capabilities,
	root_dir = root_pattern("Cargo.toml", "rust-project.json")
}
require'lspconfig'.zls.setup {
	capabilities = capabilities,
	single_file_support = true
}
vim.diagnostic.config({
	virtual_text = false
})
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.o.updatetime = 200
