local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },

        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
    },

    -- background update check but no notification
    checker = {
        enabled = true,
        notify = false,
    },
})

-- =====================================
-- Auto Lazy Sync Once Per Week
-- =====================================

local function lazy_weekly_sync()
    local state = vim.fn.stdpath("state")
    local stamp = state .. "/lazy-last-sync"
    local week = 60 * 60 * 24 * 7

    local stat = (vim.uv or vim.loop).fs_stat(stamp)

    if not stat or (os.time() - stat.mtime.sec) > week then
        vim.schedule(function()
            require("lazy").sync({ show = false })
        end)

        local f = io.open(stamp, "w")
        if f then
            f:write(tostring(os.time()))
            f:close()
        end
    end
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = lazy_weekly_sync,
})
