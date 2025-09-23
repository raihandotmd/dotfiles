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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "D", function()
      -- get current directory from netrw buffer name
      local cwd = vim.fn.expand('%:p:h')  -- full path of buffer's directory
      local fname = vim.fn.expand("<cfile>")

      if fname == "" then
        print("No file selected!")
        return
      end

      -- Construct full path safely
      local file = cwd .. "/" .. fname

      -- Check if file exists
      if vim.fn.empty(vim.fn.glob(file)) == 1 then
        print("File does not exist: " .. file)
        return
      end

      local confirm = vim.fn.confirm("Move file to trash?\n" .. file, "&Yes\n&No", 2)
      if confirm ~= 1 then
        print("Cancelled deletion.")
        return
      end

      local output = vim.fn.system("trash-put " .. vim.fn.shellescape(file))
      if vim.v.shell_error ~= 0 then
        print("Error moving file: " .. output)
      else
        print("Moved to trash: " .. file)
        vim.cmd("redraw!")
        vim.cmd("edit .")
      end
    end, { buffer = true, noremap = true, silent = true })
  end,
})

