-- Aura lualine theme — matches OpenCode's Aura dark palette
local aura = {
  bg = "#0f0f0f",
  bg_panel = "#15141b",
  fg = "#edecee",
  fg_muted = "#6d6d6d",
  border = "#2d2d2d",
  purple = "#a277ff",
  pink = "#f694ff",
  blue = "#82e2ff",
  red = "#ff6767",
  orange = "#ffca85",
  cyan = "#61ffca",
  green = "#9dff65",
}

return {
  normal = {
    a = { fg = aura.bg, bg = aura.purple, gui = "bold" },
    b = { fg = aura.fg, bg = aura.bg_panel },
    c = { fg = aura.fg_muted, bg = aura.bg },
  },
  insert = {
    a = { fg = aura.bg, bg = aura.cyan, gui = "bold" },
    b = { fg = aura.fg, bg = aura.bg_panel },
    c = { fg = aura.fg_muted, bg = aura.bg },
  },
  visual = {
    a = { fg = aura.bg, bg = aura.pink, gui = "bold" },
    b = { fg = aura.fg, bg = aura.bg_panel },
    c = { fg = aura.fg_muted, bg = aura.bg },
  },
  replace = {
    a = { fg = aura.bg, bg = aura.red, gui = "bold" },
    b = { fg = aura.fg, bg = aura.bg_panel },
    c = { fg = aura.fg_muted, bg = aura.bg },
  },
  command = {
    a = { fg = aura.bg, bg = aura.orange, gui = "bold" },
    b = { fg = aura.fg, bg = aura.bg_panel },
    c = { fg = aura.fg_muted, bg = aura.bg },
  },
  inactive = {
    a = { fg = aura.fg_muted, bg = aura.bg },
    b = { fg = aura.fg_muted, bg = aura.bg },
    c = { fg = aura.fg_muted, bg = aura.bg },
  },
}