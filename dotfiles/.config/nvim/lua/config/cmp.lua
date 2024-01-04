-- Set up nvim-cmp.
local cmp = require 'cmp'

local lspkind = require('lspkind')
require('lspkind').init({
	-- DEPRECATED (use mode instead): enables text annotations
	--
	-- default: true
	-- with_text = true,

	-- defines how annotations are shown
	-- default: symbol
	-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
	mode = 'symbol_text',

	-- default symbol map
	-- can be either 'default' (requires nerd-fonts font) or
	-- 'codicons' for codicon preset (requires vscode-codicons font)
	--
	-- default: 'default'
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

require 'cmp'.setup {
}

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
			mode = 'symbol_text', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- can also be a function to dynamically calculate max width such as
			-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, item)
				local menu_icon = {
					nvim_lsp = 'λ',
					luasnip = '⋗',
					buffer = 'Ω',
					path = '🖫',
				}
				item.menu = menu_icon[entry.source.name]
				return item
			end
		})
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'nvim_lsp', keyword_length = 1 },
		{ name = 'luasnip',  keyword_length = 2 },
		{ name = 'buffer',   keyword_length = 3 },
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


-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')["pyright"].setup {
	capabilities = capabilities
}
