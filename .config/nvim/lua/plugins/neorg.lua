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
                    { buffer = true, desc = "[neorg] journal today" })
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
                vim.keymap.set("n", "<localleader>imj", ":Neorg templates load journal<CR>",
                    { buffer = true, desc = "[neorg] inject metadata journal" })
            end,
        })
        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
    end,
}
