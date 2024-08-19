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
	'neovim/nvim-lspconfig',
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',
	'catppuccin/nvim',
	'rust-lang/rust.vim',
	'tikhomirov/vim-glsl',
	'morhetz/gruvbox',
	'seandewar/paragon.vim',
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "c", "cpp", "rust", "typescript", "javascript", "python", "tsx", "lua", "vimdoc" },
			})
		end
	}
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
vim.opt.updatetime = 1000

-- vim can lose track of syntax and highlight syntax incorrectly so when it breaks, run this
-- resources: https://github.com/vim/vim/issues/2790 and https://vim.fandom.com/wiki/Fix_syntax_highlighting
-- we might not need this anymore because of treesitter
vim.keymap.set('n', '<C-l>', '<cmd>syn sync fromstart<CR>')

vim.keymap.set('n', '<leader>fr', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>fd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gf', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>gd', vim.diagnostic.setqflist)
vim.keymap.set('n', '<leader>ge', '<cmd>lua vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})<CR>')
vim.keymap.set('n', '<leader>gw', '<cmd>lua vim.diagnostic.setqflist({severity = { min = vim.diagnostic.severity.HINT, max = vim.diagnostic.severity.WARN }})<CR>')
vim.keymap.set('n', '<C-f>', vim.lsp.buf.format)
vim.keymap.set('n', 'gh', vim.lsp.buf.hover)
-- <leader> is the '\' key
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>lg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>tr', require('telescope.builtin').resume)
vim.keymap.set('n', '<leader>tb', require('telescope.builtin').buffers)
-- taking away calling the manpages
vim.keymap.set({ 'n', 'v' }, '<S-k>', '<Nop>')
vim.keymap.set({ 'n', 'v' }, '=', '<Nop>')
vim.keymap.set("n", "<leader>d", "<cmd>lua toggle_diagnostics()<CR>")
function toggle_diagnostics() 
  if vim.diagnostic.is_disabled() then
    vim.api.nvim_echo({ { "Show diagnostics" } }, false, {})
    vim.diagnostic.enable()
  else
    vim.api.nvim_echo({ { "Disable diagnostics" } }, false, {})
    vim.diagnostic.disable()
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
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
local root_pattern = require('lspconfig').util.root_pattern

require'lspconfig'.denols.setup{
	root_dir = root_pattern("deno.json", "deno.jsonc"),
	single_file_support = false
}
require'lspconfig'.rust_analyzer.setup{
	settings = {
		['rust-analyzer'] = {
		}
	},
	root_dir = root_pattern("Cargo.toml", "rust-project.json")
}
require'lspconfig'.tsserver.setup{
	root_dir = root_pattern("tsconfig.json", "package.json"),
	single_file_support = false
}
require'lspconfig'.ccls.setup{}
require'lspconfig'.ocamllsp.setup{}
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.cmd [[autocmd BufEnter *.tsx set filetype=typescriptreact]]
vim.cmd[[
let g:matchparen_timeout = 2
let g:matchparen_insert_timeout = 2
]]
