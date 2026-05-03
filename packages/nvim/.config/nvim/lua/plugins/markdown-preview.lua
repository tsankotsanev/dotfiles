return {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    event = "BufRead",
    ft = "markdown",
    config = function()
        vim.fn["mkdp#util#install"]()
    end,
}
