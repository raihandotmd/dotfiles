return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- Load keybindings
        require("config.keymaps").plugin_keymaps.harpoon(harpoon)
    end
}
