-- Keep LazyVim's default lualine layout, and use Catppuccin's lualine theme.
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = "catppuccin-mocha"

      -- Clock is already shown in tmux.
      opts.sections = opts.sections or {}
      opts.sections.lualine_z = {
        -- Show opencode status (idle / thinking / model name) in the statusline
        { function() return require("opencode").statusline() end },
      }
    end,
  },
}
