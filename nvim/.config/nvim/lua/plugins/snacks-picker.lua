return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
          grep_word = {
            hidden = true,
          },
        },
        win = {
          input = {
            keys = {
              ["<c-]>"] = { "toggle_hidden", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<c-]>"] = "toggle_hidden",
            },
          },
        },
      },
    },
  },
}
