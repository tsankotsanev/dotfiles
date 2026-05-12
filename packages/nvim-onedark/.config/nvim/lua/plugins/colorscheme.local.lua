-- OneDark theme package.
-- Stow this package on machines that should use OneDark everywhere.

vim.g.dotfiles_lualine_theme = "onedark"

return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "dark",
        transparent = false,
        term_colors = true,
        lualine = { transparent = false },
      })
      require("onedark").load()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "onedark" },
  },
}
