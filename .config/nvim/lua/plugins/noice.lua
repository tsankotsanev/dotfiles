return {
    "folke/noice.nvim",
    config = function()
        require("noice").setup({
            views = {
                cmdline_popup = {
                    position = {
                        row = 20,
                        col = "50%",
                    },
                    size = {
                        width = 50,
                        height = "auto",
                    },
                },
            },
        })
    end,
}
