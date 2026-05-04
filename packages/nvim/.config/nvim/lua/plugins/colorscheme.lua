-- Aura theme — matches OpenCode's Aura dark palette
-- Colors sourced from: anomalyco/opencode packages/opencode/src/cli/cmd/tui/context/theme/aura.json
--
-- This is a pure highlight-based theme with no external plugin dependency.
-- It applies AFTER all other plugins load to ensure nothing overrides it.

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

local hl = vim.api.nvim_set_hl

local function apply_aura()
  -- Clear everything and set base
  vim.cmd("highlight clear")
  vim.cmd("set termguicolors")
  vim.cmd("set background=dark")
  vim.g.colors_name = "aura"

  local ns = 0

  -- ── Editor base ──
  hl(ns, "Normal",          { fg = aura.fg, bg = aura.bg })
  hl(ns, "NormalFloat",     { fg = aura.fg, bg = aura.bg_panel })
  hl(ns, "NormalNC",        { fg = aura.fg, bg = aura.bg })
  hl(ns, "SignColumn",      { fg = aura.fg_muted, bg = aura.bg })
  hl(ns, "LineNr",          { fg = aura.fg_muted, bg = aura.bg })
  hl(ns, "LineNrAbove",     { fg = aura.fg_muted })
  hl(ns, "LineNrBelow",     { fg = aura.fg_muted })
  hl(ns, "CursorLine",      { bg = aura.bg_panel })
  hl(ns, "CursorLineNr",    { fg = aura.purple, bold = true })
  hl(ns, "CursorColumn",    { bg = aura.bg_panel })
  hl(ns, "ColorColumn",     { bg = aura.bg_panel })
  hl(ns, "Whitespace",      { fg = aura.border })
  hl(ns, "NonText",         { fg = aura.border })
  hl(ns, "EndOfBuffer",     { fg = aura.border })
  hl(ns, "Cursor",          { fg = aura.bg, bg = aura.purple })
  hl(ns, "CursorIM",        { fg = aura.bg, bg = aura.purple })
  hl(ns, "TermCursor",      { fg = aura.bg, bg = aura.purple })
  hl(ns, "VertSplit",       { fg = aura.border })
  hl(ns, "WinSeparator",    { fg = aura.border })
  hl(ns, "FoldColumn",      { fg = aura.fg_muted, bg = aura.bg })
  hl(ns, "Folded",          { fg = aura.fg_muted, bg = aura.bg_panel, italic = true })

  -- ── Search / Visual ──
  hl(ns, "Search",          { fg = aura.bg, bg = aura.purple, bold = true })
  hl(ns, "IncSearch",       { fg = aura.bg, bg = aura.pink, bold = true })
  hl(ns, "CurSearch",       { fg = aura.bg, bg = aura.pink, bold = true })
  hl(ns, "Substitute",      { fg = aura.bg, bg = aura.orange })
  hl(ns, "Visual",          { bg = "#2a2040" })
  hl(ns, "VisualNOS",       { bg = "#2a2040" })
  hl(ns, "MatchParen",      { fg = aura.pink, bg = "#2a2040", bold = true })

  -- ── Pmenu ──
  hl(ns, "Pmenu",           { fg = aura.fg, bg = aura.bg_panel })
  hl(ns, "PmenuSel",        { fg = aura.fg, bg = "#2a2040" })
  hl(ns, "PmenuSbar",       { bg = aura.bg_panel })
  hl(ns, "PmenuThumb",      { bg = aura.fg_muted })
  hl(ns, "WildMenu",        { fg = aura.bg, bg = aura.purple })

  -- ── Status / Tab ──
  hl(ns, "StatusLine",      { fg = aura.fg_muted, bg = aura.bg_panel })
  hl(ns, "StatusLineNC",    { fg = aura.fg_muted, bg = aura.bg })
  hl(ns, "TabLine",         { fg = aura.fg_muted, bg = aura.bg })
  hl(ns, "TabLineFill",     { bg = aura.bg })
  hl(ns, "TabLineSel",      { fg = aura.purple, bg = aura.bg_panel, bold = true })
  hl(ns, "WinBar",          { fg = aura.fg_muted, bg = aura.bg })
  hl(ns, "WinBarNC",        { fg = aura.fg_muted, bg = aura.bg })

  -- ── Messages ──
  hl(ns, "ModeMsg",         { fg = aura.purple })
  hl(ns, "MoreMsg",         { fg = aura.cyan })
  hl(ns, "Question",        { fg = aura.orange })
  hl(ns, "Title",           { fg = aura.purple, bold = true })

  -- ── Diagnostics ──
  hl(ns, "DiagnosticError",            { fg = aura.red })
  hl(ns, "DiagnosticWarn",             { fg = aura.orange })
  hl(ns, "DiagnosticInfo",             { fg = aura.blue })
  hl(ns, "DiagnosticHint",             { fg = aura.cyan })
  hl(ns, "DiagnosticOk",               { fg = aura.green })
  hl(ns, "DiagnosticUnderlineError",   { undercurl = true, sp = aura.red })
  hl(ns, "DiagnosticUnderlineWarn",    { undercurl = true, sp = aura.orange })
  hl(ns, "DiagnosticUnderlineInfo",     { undercurl = true, sp = aura.blue })
  hl(ns, "DiagnosticUnderlineHint",    { undercurl = true, sp = aura.cyan })
  hl(ns, "DiagnosticSignError",        { fg = aura.red })
  hl(ns, "DiagnosticSignWarn",         { fg = aura.orange })
  hl(ns, "DiagnosticSignInfo",         { fg = aura.blue })
  hl(ns, "DiagnosticSignHint",         { fg = aura.cyan })

  -- ── Diff ──
  hl(ns, "DiffAdd",     { fg = aura.cyan, bg = "#354933" })
  hl(ns, "DiffChange",  { fg = aura.orange, bg = "#3a2e1a" })
  hl(ns, "DiffDelete",  { fg = aura.red, bg = "#3f191a" })
  hl(ns, "DiffText",    { fg = aura.cyan, bg = "#354933" })
  hl(ns, "Added",       { fg = aura.cyan })
  hl(ns, "Removed",     { fg = aura.red })
  hl(ns, "Changed",      { fg = aura.orange })

  -- ── Syntax (matches OpenCode Aura syntax tokens) ──
  hl(ns, "Comment",      { fg = aura.fg_muted, italic = true })
  hl(ns, "Constant",     { fg = aura.red })
  hl(ns, "String",       { fg = aura.cyan })
  hl(ns, "Character",    { fg = aura.cyan })
  hl(ns, "Number",       { fg = aura.green })
  hl(ns, "Boolean",      { fg = aura.purple })
  hl(ns, "Float",        { fg = aura.green })
  hl(ns, "Identifier",   { fg = aura.fg })
  hl(ns, "Function",     { fg = aura.purple })
  hl(ns, "Statement",    { fg = aura.pink })
  hl(ns, "Conditional",  { fg = aura.pink })
  hl(ns, "Repeat",       { fg = aura.pink })
  hl(ns, "Label",        { fg = aura.orange })
  hl(ns, "Operator",     { fg = aura.pink })
  hl(ns, "Keyword",      { fg = aura.pink })
  hl(ns, "Exception",    { fg = aura.red })
  hl(ns, "PreProc",      { fg = aura.pink })
  hl(ns, "Include",      { fg = aura.pink })
  hl(ns, "Define",       { fg = aura.pink })
  hl(ns, "Macro",        { fg = aura.pink })
  hl(ns, "Type",         { fg = aura.purple })
  hl(ns, "StorageClass", { fg = aura.pink })
  hl(ns, "Structure",    { fg = aura.purple })
  hl(ns, "Typedef",      { fg = aura.purple })
  hl(ns, "Special",      { fg = aura.orange })
  hl(ns, "SpecialChar",  { fg = aura.orange })
  hl(ns, "Tag",          { fg = aura.pink })
  hl(ns, "Delimiter",    { fg = aura.fg })
  hl(ns, "Todo",         { fg = aura.orange, bold = true })
  hl(ns, "Error",        { fg = aura.red })
  hl(ns, "Underlined",  { fg = aura.blue, underline = true })

  -- ── Treesitter ──
  hl(ns, "@comment",            { fg = aura.fg_muted, italic = true })
  hl(ns, "@keyword",           { fg = aura.pink })
  hl(ns, "@keyword.function",  { fg = aura.pink })
  hl(ns, "@keyword.operator",  { fg = aura.pink })
  hl(ns, "@function",          { fg = aura.purple })
  hl(ns, "@function.call",     { fg = aura.purple })
  hl(ns, "@function.builtin",  { fg = aura.purple })
  hl(ns, "@variable",          { fg = aura.purple })
  hl(ns, "@variable.builtin",  { fg = aura.pink })
  hl(ns, "@variable.parameter",{ fg = aura.fg })
  hl(ns, "@string",            { fg = aura.cyan })
  hl(ns, "@string.special",     { fg = aura.orange })
  hl(ns, "@number",            { fg = aura.green })
  hl(ns, "@boolean",           { fg = aura.purple })
  hl(ns, "@type",              { fg = aura.purple })
  hl(ns, "@type.builtin",      { fg = aura.pink })
  hl(ns, "@operator",          { fg = aura.pink })
  hl(ns, "@punctuation",       { fg = aura.fg })
  hl(ns, "@punctuation.bracket",   { fg = aura.fg })
  hl(ns, "@punctuation.delimiter",  { fg = aura.fg })
  hl(ns, "@property",          { fg = aura.orange })
  hl(ns, "@constant",          { fg = aura.red })
  hl(ns, "@constant.builtin",  { fg = aura.red })
  hl(ns, "@constructor",       { fg = aura.purple })
  hl(ns, "@method",            { fg = aura.purple })
  hl(ns, "@method.call",      { fg = aura.purple })
  hl(ns, "@namespace",         { fg = aura.purple })
  hl(ns, "@class",             { fg = aura.purple })
  hl(ns, "@field",             { fg = aura.fg })
  hl(ns, "@parameter",         { fg = aura.fg })
  hl(ns, "@text",              { fg = aura.fg })
  hl(ns, "@text.strong",       { fg = aura.purple, bold = true })
  hl(ns, "@text.emphasis",     { fg = aura.orange, italic = true })
  hl(ns, "@text.underline",    { underline = true })
  hl(ns, "@text.title",        { fg = aura.purple, bold = true })
  hl(ns, "@text.literal",      { fg = aura.cyan })
  hl(ns, "@text.uri",          { fg = aura.pink })
  hl(ns, "@text.reference",    { fg = aura.purple })
  hl(ns, "@tag",               { fg = aura.pink })
  hl(ns, "@tag.attribute",     { fg = aura.orange })
  hl(ns, "@tag.delimiter",    { fg = aura.fg })

  -- ── LSP semantic tokens ──
  hl(ns, "@lsp.type.class",        { fg = aura.purple })
  hl(ns, "@lsp.type.enum",        { fg = aura.purple })
  hl(ns, "@lsp.type.interface",    { fg = aura.purple })
  hl(ns, "@lsp.type.struct",       { fg = aura.purple })
  hl(ns, "@lsp.type.parameter",    { fg = aura.fg })
  hl(ns, "@lsp.type.variable",     { fg = aura.purple })
  hl(ns, "@lsp.type.property",     { fg = aura.orange })
  hl(ns, "@lsp.type.enumMember",   { fg = aura.orange })
  hl(ns, "@lsp.type.function",     { fg = aura.purple })
  hl(ns, "@lsp.type.method",       { fg = aura.purple })
  hl(ns, "@lsp.type.macro",        { fg = aura.pink })
  hl(ns, "@lsp.type.keyword",      { fg = aura.pink })
  hl(ns, "@lsp.type.number",       { fg = aura.green })
  hl(ns, "@lsp.type.string",       { fg = aura.cyan })
  hl(ns, "@lsp.type.type",         { fg = aura.purple })
  hl(ns, "@lsp.type.comment",      { fg = aura.fg_muted, italic = true })
  hl(ns, "@lsp.type.operator",     { fg = aura.pink })
  hl(ns, "@lsp.type.regexp",       { fg = aura.orange })
  hl(ns, "@lsp.type.namespace",    { fg = aura.purple })

  -- ── Markdown ──
  hl(ns, "markdownHeading1",     { fg = aura.purple, bold = true })
  hl(ns, "markdownHeading2",     { fg = aura.purple, bold = true })
  hl(ns, "markdownHeading3",     { fg = aura.pink, bold = true })
  hl(ns, "markdownHeading4",     { fg = aura.pink })
  hl(ns, "markdownLinkText",     { fg = aura.purple, underline = true })
  hl(ns, "markdownUrl",          { fg = aura.pink })
  hl(ns, "markdownCode",         { fg = aura.cyan })
  hl(ns, "markdownCodeBlock",    { fg = aura.fg })
  hl(ns, "markdownBlockQuote",   { fg = aura.fg_muted })
  hl(ns, "markdownListMarker",   { fg = aura.purple })

  -- ── Plugin highlights ──
  -- Lazy
  hl(ns, "LazyOk",          { fg = aura.cyan })
  hl(ns, "LazyError",       { fg = aura.red })
  hl(ns, "LazyCommit",      { fg = aura.purple })
  hl(ns, "LazyCommitIssue", { fg = aura.pink })
  hl(ns, "LazyDir",         { fg = aura.blue })
  hl(ns, "LazyUrl",         { fg = aura.pink })
  hl(ns, "LazyValue",       { fg = aura.purple })

  -- Telescope
  hl(ns, "TelescopeNormal",         { fg = aura.fg, bg = aura.bg_panel })
  hl(ns, "TelescopeBorder",         { fg = aura.border, bg = aura.bg_panel })
  hl(ns, "TelescopePrompt",         { fg = aura.fg, bg = aura.bg_panel })
  hl(ns, "TelescopePromptBorder",   { fg = aura.border, bg = aura.bg_panel })
  hl(ns, "TelescopePromptTitle",    { fg = aura.purple, bg = aura.bg_panel })
  hl(ns, "TelescopePreviewTitle",   { fg = aura.cyan, bg = aura.bg_panel })
  hl(ns, "TelescopeResultsTitle",    { fg = aura.pink, bg = aura.bg_panel })
  hl(ns, "TelescopeSelection",      { fg = aura.fg, bg = "#2a2040" })
  hl(ns, "TelescopeSelectionCaret", { fg = aura.purple })
  hl(ns, "TelescopeMatching",       { fg = aura.pink, bold = true })
  hl(ns, "TelescopeMultiIcon",      { fg = aura.purple })

  -- Noice
  hl(ns, "NoiceCmdline",            { fg = aura.fg })
  hl(ns, "NoiceCmdlineIcon",        { fg = aura.purple })
  hl(ns, "NoiceCmdlinePopup",       { fg = aura.fg, bg = aura.bg_panel })
  hl(ns, "NoiceCmdlinePopupBorder", { fg = aura.border })
  hl(ns, "NoiceConfirm",            { fg = aura.fg, bg = aura.bg_panel })
  hl(ns, "NoiceConfirmBorder",      { fg = aura.purple })

  -- Snacks dashboard
  hl(ns, "SnacksDashboardHeader",   { fg = aura.purple })
  hl(ns, "SnacksDashboardIcon",     { fg = aura.purple })
  hl(ns, "SnacksDashboardDesc",     { fg = aura.fg })
  hl(ns, "SnacksDashboardKey",      { fg = aura.pink })
  hl(ns, "SnacksDashboardFooter",   { fg = aura.fg_muted })
  hl(ns, "SnacksDashboardSpecial",  { fg = aura.cyan })

  -- GitSigns
  hl(ns, "GitSignsAdd",     { fg = aura.cyan })
  hl(ns, "GitSignsChange",  { fg = aura.orange })
  hl(ns, "GitSignsDelete",  { fg = aura.red })
  hl(ns, "GitSignsAddNr",   { fg = aura.cyan })
  hl(ns, "GitSignsChangeNr",{ fg = aura.orange })
  hl(ns, "GitSignsDeleteNr",{ fg = aura.red })

  -- Copilot
  hl(ns, "CopilotSuggestion", { fg = aura.fg_muted, italic = true })

  -- Float / Border
  hl(ns, "FloatBorder",  { fg = aura.border })
  hl(ns, "FloatTitle",   { fg = aura.purple, bg = aura.bg_panel })

  -- Spell
  hl(ns, "SpellBad",  { undercurl = true, sp = aura.red })
  hl(ns, "SpellCap",  { undercurl = true, sp = aura.orange })
  hl(ns, "SpellLocal",{ undercurl = true, sp = aura.blue })
  hl(ns, "SpellRare", { undercurl = true, sp = aura.purple })

  -- Quickfix
  hl(ns, "QuickFixLine", { bg = "#2a2040" })

  -- WhichKey
  hl(ns, "WhichKey",           { fg = aura.purple })
  hl(ns, "WhichKeyGroup",      { fg = aura.pink })
  hl(ns, "WhichKeyDesc",       { fg = aura.fg })
  hl(ns, "WhichKeySeperator",  { fg = aura.fg_muted })
  hl(ns, "WhichKeyFloat",      { bg = aura.bg_panel })
  hl(ns, "WhichKeyBorder",     { fg = aura.border })

  -- Notify
  hl(ns, "NotifyERRORBorder", { fg = aura.red })
  hl(ns, "NotifyWARNBorder",  { fg = aura.orange })
  hl(ns, "NotifyINFOBorder",  { fg = aura.blue })
  hl(ns, "NotifyERRORIcon",   { fg = aura.red })
  hl(ns, "NotifyWARNIcon",    { fg = aura.orange })
  hl(ns, "NotifyINFOIcon",    { fg = aura.blue })
  hl(ns, "NotifyERRORTitle",  { fg = aura.red })
  hl(ns, "NotifyWARNTitle",   { fg = aura.orange })
  hl(ns, "NotifyINFOTitle",   { fg = aura.blue })

  -- ── Terminal colors ──
  vim.g.terminal_color_0  = aura.bg
  vim.g.terminal_color_1  = aura.red
  vim.g.terminal_color_2  = aura.cyan
  vim.g.terminal_color_3  = aura.orange
  vim.g.terminal_color_4  = aura.purple
  vim.g.terminal_color_5  = aura.pink
  vim.g.terminal_color_6  = aura.blue
  vim.g.terminal_color_7  = aura.fg
  vim.g.terminal_color_8  = aura.fg_muted
  vim.g.terminal_color_9  = aura.red
  vim.g.terminal_color_10 = aura.cyan
  vim.g.terminal_color_11 = aura.orange
  vim.g.terminal_color_12 = aura.purple
  vim.g.terminal_color_13 = aura.pink
  vim.g.terminal_color_14 = aura.blue
  vim.g.terminal_color_15 = "#ffffff"
end

-- Apply immediately on load
apply_aura()

-- Also re-apply after any colorscheme change (LazyVim loads tokyonight by default)
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    apply_aura()
  end,
})

return {
  -- No external colorscheme plugin needed — Aura is applied via highlights
  -- We use a dummy plugin spec so LazyVim doesn't load tokyonight
  { "LazyVim/LazyVim", opts = { colorscheme = "aura" } },
}