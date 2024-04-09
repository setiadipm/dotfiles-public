return {
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
    init = function()
      require("lib.utils").keymap.load("gopher")
    end,
    opts = {
      commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        -- gotests = "~/go/bin/gotests",
        impl = "impl",
        iferr = "iferr",
      },
    },
  },
}
