return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    init = function()
      require("lib.utils").keymap.load("toggleterm")
    end,
    opts = {
      highlights = {
        NormalFloat = { link = "TermNormalFloat" },
        FloatBorder = { link = "TermFloatBorder" },
      },
      on_open = function()
        vim.cmd("startinsert!")
      end,
      float_opts = {
        border = "curved",
      },
    },
  },
}
