return {
  {
    "Exafunction/codeium.vim",
    event = "InsertEnter",
    init = function()
      require("lib.utils").keymap.load("codeium")
    end,
  },
}
