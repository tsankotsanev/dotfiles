return {
    -- Add colorschemes
    { "rose-pine/nvim", lazy = true },
    { "folke/tokyonight.nvim", lazy = true },

    -- Set colorscheme
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "rose-pine",
            lazy = true,
        },
    },
}
