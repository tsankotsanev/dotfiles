-- Catppuccin theme package.
-- Stow this package on machines that should use Catppuccin everywhere.

vim.g.dotfiles_lualine_theme = "catppuccin-mocha"

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        aerial = true,
        blink_cmp = true,
        fzf = true,
        gitsigns = true,
        lualine = {
          mocha = function(colors)
            local function line_bg(fg)
              return { bg = colors.base, fg = fg or colors.text }
            end

            return {
              normal = {
                -- Keep Catppuccin's stock blue NORMAL block, but make the
                -- statusline body match the editor/tmux background.
                c = line_bg(),
              },
              insert = { c = line_bg() },
              terminal = { c = line_bg() },
              command = { c = line_bg() },
              visual = { c = line_bg() },
              replace = { c = line_bg() },
              inactive = {
                a = line_bg(colors.blue),
                b = { bg = colors.base, fg = colors.surface1, gui = "bold" },
                c = line_bg(colors.overlay0),
              },
            }
          end,
        },
        mason = true,
        noice = true,
        snacks = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-mocha" },
  },
}
