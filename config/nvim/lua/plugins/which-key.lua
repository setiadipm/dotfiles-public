return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("lib.utils").keymap.load("whichkey")
    end,
    keys = {
      "<leader>",
      "<c-r>",
      "<c-w>",
      '"',
      "'",
      "`",
      "c",
      "v",
      "g",
      "z",
      "[",
      "]",
    },
    opts = {
      plugins = {
        presets = {
          g = false,
        },
      },
    },
  },
}
