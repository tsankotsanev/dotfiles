return {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
        local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                 [ @whitez ]
    ]]
        dashboard.section.header.val = vim.split(logo, "\n", { trimempty = true })
        dashboard.section.buttons.val = {
            dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
            dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
            dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
            dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
            dashboard.button("c", " " .. " Config", "<cmd> e $MYVIMRC <cr>"),
            dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
            dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
            dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
        }
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end
        -- Define custom highlight groups with Rose Pine theme colors
        -- vim.cmd([[highlight AlphaHeader guifg=#ebbcba]]) -- Header text color
        -- vim.cmd([[highlight AlphaButtons guifg=#ebbcba]]) -- Button text color
        -- vim.cmd([[highlight AlphaShortcut guifg=#ebbcba]]) -- Shortcut text color
        -- vim.cmd([[highlight AlphaFooter guifg=#ebbcba]]) -- Footer text color
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.buttons.opts.hl = "AlphaButtons"
        dashboard.section.footer.opts.hl = "AlphaFooter"
        dashboard.opts.layout[1].val = 8
        return dashboard
    end,
}
