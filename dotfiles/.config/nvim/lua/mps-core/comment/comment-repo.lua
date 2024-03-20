return
{
    "numToStr/Comment.nvim",
    opts = {},
    config = function()
        local cfg = {
            mappings = {
                basic = false,
                extra = false,
            },
        }
        require("Comment").setup(cfg)
    end,
}
