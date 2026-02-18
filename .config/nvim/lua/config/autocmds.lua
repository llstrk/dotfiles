-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local checktime_group = vim.api.nvim_create_augroup("user_checktime_aggressive", { clear = true })
local uv = vim.uv or vim.loop

local function can_checktime()
  if vim.bo.buftype ~= "" then
    return false
  end
  if vim.fn.expand("%:p") == "" then
    return false
  end
  local mode = vim.api.nvim_get_mode().mode
  return mode == "n" or mode == "no"
end

local function checktime_now()
  if can_checktime() then
    vim.cmd("silent! checktime")
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained", "TermClose", "TermLeave" }, {
  group = checktime_group,
  callback = checktime_now,
})

if vim._user_checktime_timer then
  vim._user_checktime_timer:stop()
  vim._user_checktime_timer:close()
end

local interval = vim.g.user_checktime_interval or 3000
if uv and uv.new_timer then
  local timer = uv.new_timer()
  timer:start(interval, interval, vim.schedule_wrap(checktime_now))
  vim._user_checktime_timer = timer
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = checktime_group,
  callback = function()
    if vim._user_checktime_timer then
      vim._user_checktime_timer:stop()
      vim._user_checktime_timer:close()
      vim._user_checktime_timer = nil
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = checktime_group,
  callback = function()
    vim.notify("File reloaded from disk", vim.log.levels.INFO)
  end,
})
