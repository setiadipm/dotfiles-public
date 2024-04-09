return {
  {
    "wakatime/vim-wakatime",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      require("lib.utils").keymap.load("wakatime")
    end,
  },
}
