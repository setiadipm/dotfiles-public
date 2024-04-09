local theme = require("lib.utils").theme

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = theme.is_transparent(),
      integrations = {
        cmp = true,
        neotree = true,
        noice = true,
        treesitter_context = true,
        window_picker = true,
        which_key = true,
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        transparency = theme.is_transparent,
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = theme.is_transparent(),
      background = {
        dark = "wave", -- wave | dragon | lotus
      },
    },
  },
}
