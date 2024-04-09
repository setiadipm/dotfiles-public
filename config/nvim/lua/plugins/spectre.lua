return {
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    init = function()
      require("lib.utils").keymap.load("spectre")
    end,
  },
}
