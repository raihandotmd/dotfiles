return {
    "nvim-neorg/neorg",
    lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    ft = "norg",
    dependencies = {
        { "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
        { "bottd/neorg-worklog" }
    },
    config = function()
        local ls = require("luasnip")

        require("neorg").setup({
            load = {
                ["external.templates"] = {
                    config = {
                        templates_dir = "~/hub/raihan-vault/templates",
                        keywords = {
                            UNIQUE_ID = function()
                                return ls.text_node({ vim.fn.strftime("%Y%m%d%H%M%S") })
                            end,
                            MONTH = function()
                                return ls.snippet_node(nil, { ls.text_node(os.date("%B")) })
                            end,
                        },
                        snippets_overwrite = {
                            date_format = "%Y-%m-%dT%H:%M:%S%z",
                        },
                    }
                },
                ["external.worklog"] = {
                    config = {
                        heading = "Worklog",
                        default_workspace_title = "notes"
                    }
                },

                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/hub/raihan-vault",
                        },
                        default_workspace = "notes",
                        index = "index.norg",
                    },
                },
                ["core.esupports.metagen"] = {
                    config = {
                        timezone = "local",
                        type = "none",
                        update_date = true,
                    },
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    }
                }
            },
        })
        -- Create an autocmd for Neorg filetypes
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "norg",
            callback = function()
                vim.keymap.set("n", "<localleader>vc", function()
                    if vim.o.conceallevel == 0 then
                        vim.o.conceallevel = 3 -- show icons (concealed)
                    else
                        vim.o.conceallevel = 0 -- show raw text (no icons)
                    end
                end, { buffer = true, desc = "[neorg] View Concealer, only texts" })
            end,
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>vt", ":Neorg toggle-concealer<CR>",
                    { buffer = true, desc = "[neorg] View Toggle all icons" })
            end,
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>vt", ":Neorg toggle-concealer<CR>",
                    { buffer = true, desc = "[neorg] View Toggle all icons" })
            end,
        })
        vim.keymap.set("n", "<localleader>nd", ":Neorg workspace notes<CR>",
            { desc = "[neorg] default workspaces (notes)" })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>nr", ":Neorg return<CR>",
                    { buffer = true, desc = "[neorg] return to working project" })
            end,
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>njm", ":Neorg journal<CR>",
                    { buffer = true, desc = "[neorg] journal menu" })
            end,
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>njt", ":Neorg journal today<CR>",
                    { buffer = true, desc = "[neorg] open journal today" })
            end,
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>njw", ":lua Open_weekly_journal()<CR>",
                    { buffer = true, desc = "[neorg] open journal weekly" })
            end,
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>njm", ":lua Open_monthly_journal()<CR>",
                    { buffer = true, desc = "[neorg] open journal monthly" })
            end,
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>imz", ":Neorg templates load znote<CR>",
                    { buffer = true, desc = "[neorg] inject metadata znote" })
            end,
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>imjd", ":Neorg templates load djournal<CR>",
                    { buffer = true, desc = "[neorg] inject metadata daily journal" })
            end,
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>imjw", ":Neorg templates load wjournal<CR>",
                    { buffer = true, desc = "[neorg] inject metadata weekly journal" })
            end,
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "norg" },
            callback = function()
                vim.keymap.set("n", "<localleader>imjm", ":Neorg templates load mjournal<CR>",
                    { buffer = true, desc = "[neorg] inject metadata monthly journal" })
            end,
        })

        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2

        -- Function to open weekly journal using Neorg
        function Open_weekly_journal()
            -- Get the current date
            local current_date = os.date("*t")

            -- Calculate the end of the week (next Sunday)
            local day = current_date.day
            local wday = current_date.wday

            if not day or not wday then
                print("Error: Could not retrieve day or weekday.")
                return
            end

            -- Calculate days until next Sunday
            local days_until_sunday = 8 - wday -- 0 for Sunday, 1 for Monday, ..., 6 for Saturday

            -- Calculate the date for next Sunday
            local next_sunday = os.time({
                year = current_date.year,
                month = current_date.month,
                day = day + days_until_sunday, -- Move to next Sunday
                hour = 0,
                min = 0,
                sec = 0
            })

            -- Format the date for Neorg journal command
            local formatted_date = os.date("%Y-%m-%d", next_sunday)

            -- Check if formatted_date is nil
            if not formatted_date then
                print("Error: Could not format the date.")
                return
            end

            -- Execute the Neorg journal command to open the weekly entry
            local command = "Neorg journal custom " .. formatted_date
            local ok, err = pcall(vim.cmd, command)
            if not ok then
                print("Error executing Neorg command: " .. tostring(err))
            end
        end

        function Open_monthly_journal()
            -- Get the current date
            local current_date = os.date("*t")

            -- Ensure current_date is valid
            if not current_date then
                print("Error: Could not retrieve current date.")
                return
            end

            -- Format the date for Neorg journal command (first day of the current month)
            local formatted_date = os.date("%Y-%m-01")

            -- Execute the Neorg journal command to open the monthly entry
            local command = "Neorg journal custom " .. formatted_date
            local ok, err = pcall(vim.cmd, command)
            if not ok then
                print("Error executing Neorg command: " .. tostring(err))
            end
        end
    end,
}
