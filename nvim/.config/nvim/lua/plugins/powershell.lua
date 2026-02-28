return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "powershell" },
      highlight = {
        disable = { "powershell" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        powershell_es = {
          settings = {
            powershell = {
              codeFormatting = {
                openBraceOnSameLine = true,
                newLineAfterOpenBrace = true,
              },
            },
          },
        },
      },
    },
  },
}
