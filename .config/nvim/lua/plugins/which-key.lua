return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        icons = {
            mappings = false, -- Disable icons in the which-key popup
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
