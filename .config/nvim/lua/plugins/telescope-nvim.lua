return {
    "telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").setup({
                defaults = {
                    -- ...
                },
                pickers = {
                    find_files = {
                        -- theme = "dropdown",
                    },
                },
                extensions = {
                    -- ...
                },
            })
        end,
    },
}
