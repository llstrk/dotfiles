return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local lazygit_active = nil

    local function is_lazygit_buffer(buf)
      local term = vim.b[buf].snacks_terminal
      if type(term) ~= "table" then
        return false
      end
      local cmd = term.cmd
      if type(cmd) == "table" then
        return cmd[1] == "lazygit"
      end
      return type(cmd) == "string" and cmd:find("lazygit", 1, true) ~= nil
    end

    local function set_lazygit_flag(active)
      if lazygit_active == active then
        return
      end
      lazygit_active = active

      if not vim.env.TMUX_PANE or vim.env.TMUX_PANE == "" then
        return
      end
      vim.fn.system({
        "tmux",
        "set-option",
        "-p",
        "-t",
        vim.env.TMUX_PANE,
        "@nvim_lazygit_active",
        active and "1" or "0",
      })
    end

    local function sync_lazygit_flag()
      local mode = vim.api.nvim_get_mode().mode
      local active = mode:sub(1, 1) == "t" and is_lazygit_buffer(0)
      set_lazygit_flag(active)
    end

    local group = vim.api.nvim_create_augroup("tmux_lazygit_flag", { clear = true })

    set_lazygit_flag(false)

    vim.api.nvim_create_autocmd({ "TermOpen", "TermClose", "BufEnter", "ModeChanged" }, {
      group = group,
      callback = function()
        vim.schedule(sync_lazygit_flag)
      end,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = group,
      callback = function()
        set_lazygit_flag(false)
      end,
    })

    local function term_nav(command, key)
      vim.keymap.set("t", key, function()
        if vim.bo.filetype == "fzf" then
          return key
        end
        return "<C-\\><C-n><C-w>:<C-U> " .. command .. "<CR>"
      end, {
        expr = true,
        silent = true,
        desc = "Tmux navigate from terminal",
      })
    end

    term_nav("TmuxNavigateLeft", "<C-h>")
    term_nav("TmuxNavigateDown", "<C-j>")
    term_nav("TmuxNavigateUp", "<C-k>")
    term_nav("TmuxNavigateRight", "<C-l>")
  end,
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", mode = "n", desc = "Go to left split" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>", mode = "n", desc = "Go to lower split" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>", mode = "n", desc = "Go to upper split" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>", mode = "n", desc = "Go to right split" },
  },
}
