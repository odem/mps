-- Set up nvim-cmp.
local cmp = require 'cmp'

local luasnip = require 'luasnip'
local lspkind = require('lspkind')
require('luasnip.loaders.from_vscode').lazy_load()
require('lspkind').init({
	mode = 'symbol_text',
	preset = 'default',
	-- override preset symbols
	--
	-- default: {}
	-- symbol_map = {
	-- 	Text = "󰉿",
	-- 	Method = "󰆧",
	-- 	Function = "",
	-- 	Constructor = "",
	-- 	Field = "󰜢",
	-- 	Variable = "󰀫",
	-- 	Class = "󰠱",
	-- 	Interface = "",
	-- 	Module = "",
	-- 	Property = "󰜢",
	-- 	Unit = "󰑭",
	-- 	Value = "󰎠",
	-- 	Enum = "",
	-- 	Keyword = "󰌋",
	-- 	Snippet = "",
	-- 	Color = "󰏘",
	-- 	File = "󰈙",
	-- 	Reference = "󰈇",
	-- 	Folder = "󰉋",
	-- 	EnumMember = "",
	-- 	Constant = "󰏿",
	-- 	Struct = "󰙅",
	-- 	Event = "",
	-- 	Operator = "󰆕",
	-- 	TypeParameter = "",
	-- },
})

cmp.setup({
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,

	source = {
		path = true,
		buffer = true,
		calc = true,
		nvim_lsp = true,
		nvim_lua = true,
		vsnip = false,
	},
	formatting = {
		expandable_indicator = true,
		fields = { 'menu', 'abbr', 'kind' },
		format = lspkind.cmp_format({
			mode = 'symbol_text',
			maxwidth = 50,
			ellipsis_char = '...',
			before = function(entry, item)
				local menu_icon = {
					nvim_lsp = 'λ',
					luasnip = '⋗',
					buffer = 'Ω',
					vim_dadbod_completion = "",
					path = '🖫',
				}
				item.menu = menu_icon[entry.source.name]
				return item
			end,
		})
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	},

	mapping = cmp.mapping.preset.insert({
		['<Down>'] = cmp.mapping.select_next_item(),
		['<Up>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<C-v>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<C-z>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'nvim_lsp',              keyword_length = 1 },
		{ name = 'luasnip',               keyword_length = 2 },
		{ name = 'buffer',                keyword_length = 3 },
		{ name = "vim-dadbod-completion", keyword_length = 4 },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = ''
	})
end

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '»' })

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = 'rounded',
		source = 'rounded',
	},
})
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	vim.lsp.handlers.hover,
	{ border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
	vim.lsp.handlers.signature_help,
	{ border = 'rounded' }
)

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')["pyright"].setup {
	capabilities = capabilities
}
