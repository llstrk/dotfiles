return {
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gvo", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gvc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>gvh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview History (Repo)" },
      { "<leader>gvf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview History (File)" },
      { "<leader>gvt", "<cmd>DiffviewToggleFiles<cr>", desc = "Diffview Toggle Files" },
      { "<leader>gvr", "<cmd>DiffviewRefresh<cr>", desc = "Diffview Refresh" },
    },
  },
}
