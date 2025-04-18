require("barbecue").setup({
	theme = {
		-- this highlight is used to override other highlights
		-- you can take advantage of its `bg` and set a background throughout your winbar
		-- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
		normal = { fg = "#c0caf5" },

		-- these highlights correspond to symbols table from config
		ellipsis = { fg = "#737aa2" },
		separator = { fg = "#737aa2" },
		modified = { fg = "#737aa2" },

		-- these highlights represent the _text_ of three main parts of barbecue
		dirname = { fg = "#737aa2" },
		basename = { bold = true },
		context = {},

		-- these highlights are used for context/navic icons
		context_file = { fg = "#ac8fe4" },
		context_module = { fg = "#ac8fe4" },
		context_namespace = { fg = "#ac8fe4" },
		context_package = { fg = "#ac8fe4" },
		context_class = { fg = "#ac8fe4" },
		context_method = { fg = "#ac8fe4" },
		context_property = { fg = "#ac8fe4" },
		context_field = { fg = "#ac8fe4" },
		context_constructor = { fg = "#ac8fe4" },
		context_enum = { fg = "#ac8fe4" },
		context_interface = { fg = "#ac8fe4" },
		context_function = { fg = "#ac8fe4" },
		context_variable = { fg = "#ac8fe4" },
		context_constant = { fg = "#ac8fe4" },
		context_string = { fg = "#ac8fe4" },
		context_number = { fg = "#ac8fe4" },
		context_boolean = { fg = "#ac8fe4" },
		context_array = { fg = "#ac8fe4" },
		context_object = { fg = "#ac8fe4" },
		context_key = { fg = "#ac8fe4" },
		context_null = { fg = "#ac8fe4" },
		context_enum_member = { fg = "#ac8fe4" },
		context_struct = { fg = "#ac8fe4" },
		context_event = { fg = "#ac8fe4" },
		context_operator = { fg = "#ac8fe4" },
		context_type_parameter = { fg = "#ac8fe4" },
	},
	{
		---Whether to attach navic to language servers automatically.
		---
		---@type boolean
		attach_navic = true,

		---Whether to create winbar updater autocmd.
		---
		---@type boolean
		create_autocmd = true,

		---Buftypes to enable winbar in.
		---
		---@type string[]
		include_buftypes = { "" },

		---Filetypes not to enable winbar in.
		---
		---@type string[]
		exclude_filetypes = { "netrw", "toggleterm" },

		modifiers = {
			---Filename modifiers applied to dirname.
			---
			---See: `:help filename-modifiers`
			---
			---@type string
			dirname = ":~:.",

			---Filename modifiers applied to basename.
			---
			---See: `:help filename-modifiers`
			---
			---@type string
			basename = "",
		},

		---Whether to display path to file.
		---
		---@type boolean
		show_dirname = true,

		---Whether to display file name.
		---
		---@type boolean
		show_basename = true,

		---Whether to replace file icon with the modified symbol when buffer is
		---modified.
		---
		---@type boolean
		show_modified = true,

		---Get modified status of file.
		---
		---NOTE: This can be used to get file modified status from SCM (e.g. git)
		---
		---@type fun(bufnr: number): boolean
		modified = function(bufnr)
			return vim.bo[bufnr].modified
		end,

		---Whether to show/use navic in the winbar.
		---
		---@type boolean
		show_navic = true,

		---Get leading custom section contents.
		---
		---NOTE: This function shouldn't do any expensive actions as it is run on each
		---render.
		---
		---@type fun(bufnr: number, winnr: number): barbecue.Config.custom_section
		lead_custom_section = function()
			return " "
		end,

		---@alias barbecue.Config.custom_section
		---|string # Literal string.
		---|{ [1]: string, [2]: string? }[] # List-like table of `[text, highlight?]` tuples in which `highlight` is optional.
		---
		---Get custom section contents.
		---
		---NOTE: This function shouldn't do any expensive actions as it is run on each
		---render.
		---
		---@type fun(bufnr: number, winnr: number): barbecue.Config.custom_section
		custom_section = function()
			return " "
		end,

		---Whether context text should follow its icon's color.
		---
		---@type boolean
		context_follow_icon_color = false,

		symbols = {
			---Modification indicator.
			---
			---@type string
			modified = "●",

			---Truncation indicator.
			---
			---@type string
			ellipsis = "…",

			---Entry separator.
			---
			---@type string
			separator = "|",
		},

		---@alias barbecue.Config.kinds
		---|false # Disable kind icons.
		---|table<string, string> # Type to icon mapping.
		---
		---Icons for different context entry kinds.
		---
		---@type barbecue.Config.kinds
		kinds = {
			File = "",
			Module = "",
			Namespace = "",
			Package = "",
			Class = "",
			Method = "",
			Property = "",
			Field = "",
			Constructor = "",
			Enum = "",
			Interface = "",
			Function = "",
			Variable = "",
			Constant = "",
			String = "",
			Number = "",
			Boolean = "",
			Array = "",
			Object = "",
			Key = "",
			Null = "",
			EnumMember = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
	},
})
