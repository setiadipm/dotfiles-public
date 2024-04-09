return {
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    init = function()
      require("lib.utils").keymap.load("tmuxnavigator")
    end,
  },
}
