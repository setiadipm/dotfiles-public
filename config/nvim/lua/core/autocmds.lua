local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("nvim_" .. name, { clear = true })
end

-- Set indentation for certain file type
vim.cmd("autocmd Filetype php,css setlocal ts=4 sw=4")

-- Setting colorscheme is triggered in core/init.lua
autocmd("ColorScheme", {
  desc = "Load custom highlights from user configuration",
  group = augroup("custom_highlights"),
  callback = function()
    if vim.g.colors_name then
      for _, module in ipairs({ vim.g.colors_name, "init" }) do
        local ok, highlights = pcall(require, "highlights." .. module)
        if ok then
          for group, spec in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, spec)
          end
        end
      end
    end
  end,
})

autocmd("BufReadPost", {
  desc = "Go to last location when opening a buffer",
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("FileType", {
  desc = "Close some filetypes with <q>",
  group = augroup("close_with_q"),
  pattern = {
    "checkhealth",
    "fugitive",
    "git",
    "help",
    "lspinfo",
    "man",
    "notify",
    "PlenaryTestPopup",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    local keymap = require("lib.utils").keymap.set

    vim.bo[event.buf].buflisted = false
    keymap("n", "q", ":close<CR>", { buffer = event.buf })
  end,
})

autocmd({ "BufWritePre" }, {
  desc = "Auto create dir when saving a file in case some intermediate directory does not exist",
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
