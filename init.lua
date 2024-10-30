local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	-- 'neovim/nvim-lspconfig',
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',
	'catppuccin/nvim',
	'rust-lang/rust.vim',
	'tikhomirov/vim-glsl',
	'morhetz/gruvbox',
	'seandewar/paragon.vim',
	'junegunn/fzf',
	'junegunn/fzf.vim',
	{
		'neoclide/coc.nvim',
		build = "npm i && npm build",
		lazy = false
	},
})
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.ts = 2
vim.opt.sw = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smartcase = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.modelines = 0
-- vim.opt.lcs = 'eol:$,tab: >,trail:-,space:>'
-- vim.opt.list = true
vim.opt.signcolumn = 'yes'
vim.opt.shadafile = "NONE"

vim.opt.synmaxcol = 1000

-- vim can lose track of syntax and highlight syntax incorrectly so when it breaks, run this
-- resources: https://github.com/vim/vim/issues/2790 and https://vim.fandom.com/wiki/Fix_syntax_highlighting
-- we might not need this anymore because of treesitter
vim.keymap.set('n', '<C-l>', '<cmd>syn sync fromstart<CR>')

vim.api.nvim_create_user_command('Fmt', 'lua vim.fn.CocAction("format")<CR>', {})
vim.keymap.set('n', '<leader>fr', '<cmd>lua vim.fn.CocActionAsync("jumpReferences")<CR>')
vim.keymap.set('n', '<leader>fd', '<cmd>lua vim.fn.CocActionAsync("jumpDefinition")<CR>')
vim.keymap.set('n', '<leader>gd', '<cmd>CocDiagnostic<CR>')
vim.cmd[[inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]]
vim.keymap.set('n', 'gh', '<cmd>lua vim.fn.CocActionAsync("doHover")<CR>')
-- <leader> is the '\' key
vim.keymap.set('n', '<leader>ff', '<cmd>Files<CR>')
vim.keymap.set('n', '<leader>lg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>tb', '<cmd>Buffers<CR>')
-- taking away calling the manpages
vim.keymap.set({ 'n', 'v' }, '<S-k>', '<Nop>')
vim.keymap.set({ 'n', 'v' }, '=', '<Nop>')
-- taking away 'goto file'
vim.keymap.set({ 'n', 'v' }, 'gf', '<Nop>')

vim.keymap.set("n", "<leader>d", "<cmd>lua toggle_diagnostics()<CR>")
local diagnostics = true
function toggle_diagnostics() 
  if diagnostics == false then
		diagnostics = true
		vim.cmd[[:CocEnable]]
  else
		diagnostics = false
		vim.cmd[[:CocDisable]]
  end
end
vim.diagnostic.config({
	virtual_text = false,
	underline = false,
})

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = true, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
				native_lsp = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

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
      },
			n = {
				["dd"] = "delete_buffer"
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

-- lspconfig is too slow with tsserver for now
-- local root_pattern = require('lspconfig').util.root_pattern
--
-- require'lspconfig'.denols.setup{
-- 	root_dir = root_pattern("deno.json", "deno.jsonc"),
-- 	single_file_support = false
-- }
-- require'lspconfig'.rust_analyzer.setup{
-- 	settings = {
-- 		['rust-analyzer'] = {
-- 		}
-- 	},
-- 	root_dir = root_pattern("Cargo.toml", "rust-project.json")
-- }
-- require'lspconfig'.tsserver.setup{
-- 	root_dir = root_pattern("tsconfig.json", "package.json"),
-- 	single_file_support = false
-- }
-- require'lspconfig'.ccls.setup{}
-- require'lspconfig'.ocamllsp.setup{}
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.cmd [[autocmd BufEnter *.tsx set filetype=typescriptreact]]
vim.cmd[[
let g:matchparen_timeout = 2
let g:matchparen_insert_timeout = 2
]]
