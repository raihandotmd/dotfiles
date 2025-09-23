return {
    'vyfor/cord.nvim',
    build = ':Cord update',
    opts = {
        editor = {
            tooltip = 'Zen'
        },
        text = {
            workspace = '',         -- Omit the text from the activity, meaning it will only have one row of text
            games = function() end, -- Returning `nil` is the same as above

            viewing = 'Viewing',
            file_browser = 'Browsing', -- Ignore these types of buffers and the current activity will remain unchanged
            editing = 'Focus Mode',
            plugin_manager = false,    -- Hide the activity for these types of buffers

            -- Also applicable to functions
            diagnostics = function(opts)
                -- Only show diagnostics activity if there are problems, otherwise do nothing
                return #vim.diagnostics.get(vim.api.nvim_get_current_buf()) > 0 and 'Fixing problems in ' .. opts
                    .tooltip or true
            end,
        }
    }
}
