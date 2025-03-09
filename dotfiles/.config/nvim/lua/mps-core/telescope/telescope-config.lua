-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		path_display = { "smart" },
		layout_config = {
			bottom_pane = {
				height = 25,
				preview_cutoff = 120,
				prompt_position = "top",
			},
			center = {
				height = 0.4,
				preview_cutoff = 40,
				prompt_position = "top",
				width = 0.5,
			},
			cursor = {
				height = 0.9,
				preview_cutoff = 40,
				width = 0.8,
			},
			horizontal = {
				height = 0.9,
				preview_cutoff = 120,
				prompt_position = "bottom",
				width = 0.8,
			},
			vertical = {
				height = 0.9,
				preview_cutoff = 40,
				prompt_position = "bottom",
				width = 0.8,
			},
		},
		selection_caret = "",
		winblend = 10,
		wrap_results = false,
		border = true,
		layout_strategy = "horizontal",
		mappings = {
			i = {
				["<C-y>"] = true,
				["<C-x>"] = false,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

