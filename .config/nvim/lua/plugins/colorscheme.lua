return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            transparent_background = false,
            custom_highlights = {
                Normal = { bg = "#1e2030" },
            },
        },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
            lazy = true,
        },
    },
}
