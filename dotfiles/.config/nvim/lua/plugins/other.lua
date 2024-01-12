return {
    { "folke/which-key.nvim",          opts = {} },
    { "mbbill/undotree" },
    { "saadparwaiz1/cmp_luasnip" },
    { "neovim/nvim-lspconfig" },
    { "onsails/lspkind.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/nvim-cmp" },
    { "nvim-lualine/lualine.nvim" },
    { "akinsho/toggleterm.nvim",       version = "*",         config = true },
    { "nvim-tree/nvim-web-devicons",   opts = {} },
    { "goolord/alpha-nvim" },
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },
    { "norcalli/nvim-colorizer.lua" },
    { "nvim-lua/plenary.nvim" },
    { "AckslD/swenv.nvim" },
    { "nvim-tree/nvim-tree.lua" },
    { "RRethy/vim-illuminate" },
    { "sakhnik/nvim-gdb" },
    { "airblade/vim-gitgutter" },
    { "windwp/nvim-autopairs",         event = "InsertEnter", },
    { "stevearc/dressing.nvim" },
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },
    { "tpope/vim-sleuth" },
    { "voldikss/vim-browser-search" },
    { "theprimeagen/harpoon" },
    { "MunifTanjim/nui.nvim" },
    { "rcarriga/nvim-notify" },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }
    --    { "mg979/vim-visual-multi" },
    --    { "tiagofumo/vim-nerdtree-syntax-highlight" },

}
