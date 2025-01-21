require("config.opts")
require("config.keymaps").setup()
require("config.lazy")

local augroup = vim.api.nvim_create_augroup
local ProjectRaihanGroup = augroup('ProjectRaihan', {})
local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    group = ProjectRaihanGroup,
    callback = function(e)
        require("config.keymaps").plugin_keymaps.lsp(e.buf)
    end
})
