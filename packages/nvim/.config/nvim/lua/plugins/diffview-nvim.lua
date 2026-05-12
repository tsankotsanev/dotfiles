-- diffview.nvim — full repo diff / git log browser
-- https://github.com/sindrets/diffview.nvim
return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewFileHistory",
  },
  keys = {
    -- ── Diff view ────────────────────────────────────────────────────────
    { "<leader>gd",  "<cmd>DiffviewOpen<cr>",              desc = "Diff view (working tree vs HEAD)" },
    { "<leader>gD",  "<cmd>DiffviewOpen HEAD~1<cr>",       desc = "Diff view (HEAD vs HEAD~1)" },
    { "<leader>gc",  "<cmd>DiffviewClose<cr>",             desc = "Close diff view" },
    -- ── File history ─────────────────────────────────────────────────────
    { "<leader>gfh", "<cmd>DiffviewFileHistory %<cr>",     desc = "File history (current file)" },
    { "<leader>gfH", "<cmd>DiffviewFileHistory<cr>",       desc = "File history (whole repo)" },
    -- Visual mode: history for selected lines only
    { "<leader>gfh", "<cmd>'<,'>DiffviewFileHistory<cr>",  desc = "File history (selection)", mode = "x" },
  },
  opts = {
    enhanced_diff_hl = true, -- richer diff highlights
    view = {
      -- Side-by-side diff (default); change to "diff1_plain" for unified
      default = {
        layout = "diff2_horizontal",
      },
      merge_tool = {
        layout = "diff3_horizontal",
        disable_diagnostics = true,
      },
    },
    file_panel = {
      listing_style = "tree",
      win_config = { width = 35 },
    },
    hooks = {
      -- Close diffview automatically when the last buffer is closed
      view_closed = function()
        -- nothing extra needed; diffview handles cleanup
      end,
    },
  },
}
