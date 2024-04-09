local colors = require("kanagawa.colors").setup()
local palette = colors.palette
local theme = colors.theme

-- Palette
-- https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
-- -- Bg Shades
-- sumiInk0 = "#16161D",
-- sumiInk1 = "#181820",
-- sumiInk2 = "#1a1a22",
-- sumiInk3 = "#1F1F28",
-- sumiInk4 = "#2A2A37",
-- sumiInk5 = "#363646",
-- sumiInk6 = "#54546D", --fg
-- -- Popup and Floats
-- waveBlue1 = "#223249",
-- waveBlue2 = "#2D4F67",
-- -- Diff and Git
-- winterGreen = "#2B3328",
-- winterYellow = "#49443C",
-- winterRed = "#43242B",
-- winterBlue = "#252535",
-- autumnGreen = "#76946A",
-- autumnRed = "#C34043",
-- autumnYellow = "#DCA561",
-- -- Diag
-- samuraiRed = "#E82424",
-- roninYellow = "#FF9E3B",
-- waveAqua1 = "#6A9589",
-- dragonBlue = "#658594",
-- -- Fg and Comments
-- oldWhite = "#C8C093",
-- fujiWhite = "#DCD7BA",
-- fujiGray = "#727169",
-- oniViolet = "#957FB8",
-- oniViolet2 = "#b8b4d0",
-- crystalBlue = "#7E9CD8",
-- springViolet1 = "#938AA9",
-- springViolet2 = "#9CABCA",
-- springBlue = "#7FB4CA",
-- lightBlue = "#A3D4D5", -- unused yet
-- waveAqua2 = "#7AA89F", -- improve lightness: desaturated greenish Aqua
-- -- waveAqua2  = "#68AD99",
-- -- waveAqua4  = "#7AA880",
-- -- waveAqua5  = "#6CAF95",
-- -- waveAqua3  = "#68AD99",
-- springGreen = "#98BB6C",
-- boatYellow1 = "#938056",
-- boatYellow2 = "#C0A36E",
-- carpYellow = "#E6C384",
-- sakuraPink = "#D27E99",
-- waveRed = "#E46876",
-- peachRed = "#FF5D62",
-- surimiOrange = "#FFA066",
-- katanaGray = "#717C7C",
-- dragonBlack0 = "#0d0c0c",
-- dragonBlack1 = "#12120f",
-- dragonBlack2 = "#1D1C19",
-- dragonBlack3 = "#181616",
-- dragonBlack4 = "#282727",
-- dragonBlack5 = "#393836",
-- dragonBlack6 = "#625e5a",
-- dragonWhite = "#c5c9c5",
-- dragonGreen = "#87a987",
-- dragonGreen2 = "#8a9a7b",
-- dragonPink = "#a292a3",
-- dragonOrange = "#b6927b",
-- dragonOrange2 = "#b98d7b",
-- dragonGray = "#a6a69c",
-- dragonGray2 = "#9e9b93",
-- dragonGray3 = "#7a8382",
-- dragonBlue2 = "#8ba4b0",
-- dragonViolet= "#8992a7",
-- dragonRed = "#c4746e",
-- dragonAqua = "#8ea4a2",
-- dragonAsh = "#737c73",
-- dragonTeal = "#949fb5",
-- dragonYellow = "#c4b28a",--"#a99c8b",
return {
  Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
  PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
  PmenuSbar = { bg = theme.ui.bg_m1 },
  PmenuThumb = { bg = theme.ui.bg_p2 },

  TelescopeTitle = { fg = theme.ui.special, bold = true },
  TelescopePromptNormal = { bg = theme.ui.bg_p1 },
  TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
  TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
  TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
  TelescopePreviewNormal = { bg = theme.ui.bg_dim },
  TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

  -- NormalFloat = { bg = "none" },
  -- FloatBorder = { bg = "none" },
  -- FloatTitle = { bg = "none" },

  -- Save an hlgroup with dark background and dimmed foreground
  -- so that you can use it where your still want darker windows.
  -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
  NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

  -- Popular plugins that open floats will link to NormalFloat by default;
  -- set their background accordingly if you wish to keep them dark and borderless
  LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
}
