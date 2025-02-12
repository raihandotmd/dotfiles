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

-- put deleted files in trash dir
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "D", function()
      local cwd = vim.fn.getcwd()                    -- get the current directory from netrw
      local fname = vim.fn.expand("<cfile>")         -- get the selected file name
      if fname == "" then
        print("No file selected!")
        return
      end
      local file = cwd .. "/" .. fname              -- construct full path
      -- Prompt for confirmation:
      local confirm = vim.fn.confirm("Move file to trash?\n" .. file, "&Yes\n&No", 2)
      if confirm ~= 1 then
        print("Cancelled deletion.")
        return
      end

      -- Attempt to move the file to trash:
      local output = vim.fn.system("trash-put " .. vim.fn.shellescape(file))
      if vim.v.shell_error ~= 0 then
        print("Error moving file: " .. output)
      else
        print("Moved to trash: " .. file)
        vim.cmd("redraw!")  -- refresh the UI
        -- Optionally, refresh netrw's listing:
        vim.cmd("edit .")
      end
    end, { buffer = true, noremap = true, silent = true })
  end,
})

