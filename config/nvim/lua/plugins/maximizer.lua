return {
  {
    "szw/vim-maximizer",
    cmd = "MaximizerToggle",
    init = function()
      require("lib.utils").keymap.load("maximizer")
    end,
  },
}
