return {
  "coder/claudecode.nvim",
  config = true,
  keys = {
    { "<leader>cca", nil, desc = "AI/Claude Code" },
    { "<leader>cct", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>ccf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ccr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>ccC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>ccm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ccb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>ccs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>ccp",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
    -- Diff management
    { "<leader>ccy", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ccd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
