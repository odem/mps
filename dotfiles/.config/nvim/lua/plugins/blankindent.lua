local highlight = {
    "Whitespace",
    "CursorColumn",
}

return
{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = {
        indent = {
            char = "",
            tab_char = { "|" },
            highlight = highlight,
            smart_indent_cap = true,
            priority = 2,

        },
        whitespace = {
            highlight = highlight,
            remove_blankline_trail = false,
        },

        scope = {
            enabled = true,
            show_start = true,
            show_end = false,
            show_exact_scope = true,
            highlight = highlight,
            priority = 500,
        },
    },
}
