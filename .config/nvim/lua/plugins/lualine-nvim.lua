local custom_catppuccin = require("lualine.themes.catppuccin")
custom_catppuccin.normal.c.bg = "#1e1e2e"

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        return {
            options = {
                theme = custom_catppuccin,
            },
        }
    end,
}
