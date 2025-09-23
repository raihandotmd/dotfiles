-- Set leader keys
vim.g.mapleader = " "       -- Space as the main leader key
vim.g.maplocalleader = "\\" -- Backslash as the local leader key

local M = {}

-- General keymaps
M.general_keymaps = function()
    -- File explorer and Git commands
    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Git status" })

    -- Visual mode movements
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

    -- Normal mode enhancements
    vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
    vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
    vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
    vim.keymap.set("n", "n", "nzzzv", { desc = "Search next and center cursor" })
    vim.keymap.set("n", "N", "Nzzzv", { desc = "Search previous and center cursor" })

    -- Yank and delete
    vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
    vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
    vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
    vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without overwriting register" })

    -- Miscellaneous
    vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
    vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q command" })
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code using LSP" })

    -- Quickfix and location list navigation
    vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next item in quickfix list" })
    vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous item in quickfix list" })
    vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next item in location list" })
    vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous item in location list" })

    -- Search and file permissions
    vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
        { desc = "Search and replace current word" })
    vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

    -- Copilot Chat
    vim.keymap.set("n", "<leader>cco", vim.cmd.CopilotChatOpen, { desc = "Copilot Chat Open" })
end

-- Plugin-specific keymaps
M.plugin_keymaps = {
    harpoon = function(harpoon)
        vim.keymap.set("n", "<leader>A", function() harpoon:list():prepend() end)
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end)
        vim.keymap.set("n", "<leader><C-t>", function() harpoon:list():replace_at(2) end)
        vim.keymap.set("n", "<leader><C-n>", function() harpoon:list():replace_at(3) end)
        vim.keymap.set("n", "<leader><C-s>", function() harpoon:list():replace_at(4) end)
    end,
    telescope = function(builtin)
        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find files" })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git files" })
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Help tags" })
    end,
    lsp = function(bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", unpack(opts) })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "view hover information", unpack(opts) })
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol,
            { desc = "view workspace symbols", unpack(opts) })
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float,
            { desc = "view diagnostics in a floating window", unpack(opts) })
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { desc = "view code actions", unpack(opts) })
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, { desc = "view references", unpack(opts) })
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { desc = "Rename symbol", unpack(opts) })
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "view signature help", unpack(opts) })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", unpack(opts) })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", unpack(opts) })
    end,
}


-- Setup function
function M.setup()
    M.general_keymaps()
end

return M
