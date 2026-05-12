-- Keep LazyVim's default lualine layout.
-- Theme packages set vim.g.dotfiles_lualine_theme (for example
-- "catppuccin-mocha" or "onedark"). If no theme package is stowed, lualine
-- falls back to auto-detecting from the active colorscheme.
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = vim.g.dotfiles_lualine_theme or "auto"

      -- Clock is already shown in tmux.
      opts.sections = opts.sections or {}
      opts.sections.lualine_z = {
        -- Show opencode status (idle / thinking / model name) in the statusline
        { function() return require("opencode").statusline() end },
      }
    end,
  },
}
