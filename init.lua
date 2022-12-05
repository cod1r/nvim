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
vim.opt.lcs = 'eol:$,tab: >,trail:-,space:-'
vim.opt.list = true
vim.opt.signcolumn = 'no'
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
		Plug 'eemed/sitruuna.vim'
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
		Plug 'ellisonleao/gruvbox.nvim'
		Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
		call plug#end()
		color catppuccin
		"color sitruuna
		"color gruvbox
		"color tokyonight
		let g:zig_fmt_autosave = 0
]])
-- <leader> is the '\' key
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
vim.keymap.set('n', '<S-k>', '<Nop>')
vim.keymap.set('n', '<S-j>', '<Nop>')
vim.keymap.set("n", "<leader>d", "<cmd>lua toggle_diagnostics()<CR>")
diagnostics_active = true
toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.api.nvim_echo({ { "Show diagnostics" } }, false, {})
    vim.diagnostic.enable()
  else
    vim.api.nvim_echo({ { "Disable diagnostics" } }, false, {})
    vim.diagnostic.disable()
  end
end

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
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
-- vim.diagnostic.config({
-- 	virtual_text = false
-- })
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.o.updatetime = 200
