return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "javascript",
            "typescript",
            "terraform",
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query"
        },

        sync_install = false,

        auto_install = true,

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    })
    end
}
