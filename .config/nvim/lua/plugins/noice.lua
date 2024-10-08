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
                        width = 40,
                        height = "auto",
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 23,
                        col = "50%",
                    },
                    size = {
                        width = 40,
                        height = 10,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        })
    end,
}
