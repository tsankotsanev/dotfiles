-- opencode.nvim — integrate OpenCode AI into Neovim
-- https://github.com/nickjvandyke/opencode.nvim
return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- track latest stable release
  dependencies = {
    -- snacks.nvim is already in your config; mark it optional so lazy
    -- doesn't re-install it, but wire up the enhanced input/picker.
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- enhances ask() with a nicer input box
        picker = {  -- enhances select() with previews
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                -- <Alt-a> sends the selected item to opencode
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- All defaults are sensible; override here if needed.
      -- e.g. to pin a specific model:
      --   model = "anthropic/claude-sonnet-4-6",
    }

    -- Required so Neovim auto-reloads files that opencode edits on disk.
    vim.o.autoread = true

    -- ── Toggle / navigation ──────────────────────────────────────────────
    -- <C-.>  toggle the opencode panel (normal + terminal mode)
    vim.keymap.set({ "n", "t" }, "<C-.>", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    -- Scroll the opencode panel without leaving your buffer
    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })

    -- ── Ask / select ─────────────────────────────────────────────────────
    -- <leader>oa  ask opencode about the current context (visual or cursor)
    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode (@this)" })

    -- <leader>os  open the select menu (prompts, commands, server controls)
    vim.keymap.set({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "Select opencode action" })

    -- ── Operator (go + motion / visual) ──────────────────────────────────
    -- go<motion>  add the motion range to opencode; goo for current line
    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })
  end,
}
