return {
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        opts = function()
            -- Cache git root path
            local git_root_cache = nil

            -- Function to get the relative path from the Git root
            local function get_relative_path()
                local filepath = vim.fn.expand('%:p')
                if not git_root_cache then
                    git_root_cache = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('%s+', '')
                end
                if git_root_cache ~= '' then
                    return filepath:gsub(git_root_cache .. '/', '') -- Remove the Git root from the path
                else
                    return filepath                                 -- Return full path if not in a Git repo
                end
            end

            -- Function to check for uncommitted changes using git status
            local function get_git_status()
                local handle = io.popen("git status --porcelain 2>/dev/null")

                if not handle then
                    return ''
                end

                local result = handle:read("*a")
                handle:close()

                -- Check if there are any changes
                return result ~= '' and '*' or ''
            end

            -- Update git root cache on entering a buffer
            vim.api.nvim_create_autocmd("BufEnter", {
                callback = function()
                    git_root_cache = nil -- Reset cache when entering a new buffer
                end,
            })

            -- Configure lualine sections
            return {
                options = {
                    theme = 'iceberg_dark',
                    component_separators = '',
                    section_separators = '',
                },
                sections = {
                    lualine_a = { get_relative_path },
                    lualine_b = { get_git_status },
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { '%p%%' }, -- Show percentage of file scrolled
                },
            }
        end,
    },
}
