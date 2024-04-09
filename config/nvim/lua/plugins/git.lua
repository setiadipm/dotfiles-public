return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      require("lib.utils").keymap.load("gitsigns")
    end,
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gvdiff" },
    init = function()
      require("lib.utils").keymap.load("fugitive")
    end,
  },
}
