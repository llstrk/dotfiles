return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to left split" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to lower split" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to upper split" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right split" },
  },
}
