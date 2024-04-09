local colors = require("catppuccin.palettes").get_palette()

-- Palette
-- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/mocha.lua
-- 	rosewater = "#f5e0dc",
-- 	flamingo = "#f2cdcd",
-- 	pink = "#f5c2e7",
-- 	mauve = "#cba6f7",
-- 	red = "#f38ba8",
-- 	maroon = "#eba0ac",
-- 	peach = "#fab387",
-- 	yellow = "#f9e2af",
-- 	green = "#a6e3a1",
-- 	teal = "#94e2d5",
-- 	sky = "#89dceb",
-- 	sapphire = "#74c7ec",
-- 	blue = "#89b4fa",
-- 	lavender = "#b4befe",
-- 	text = "#cdd6f4",
-- 	subtext1 = "#bac2de",
-- 	subtext0 = "#a6adc8",
-- 	overlay2 = "#9399b2",
-- 	overlay1 = "#7f849c",
-- 	overlay0 = "#6c7086",
-- 	surface2 = "#585b70",
-- 	surface1 = "#45475a",
-- 	surface0 = "#313244",
-- 	base = "#1e1e2e",
-- 	mantle = "#181825",
-- 	crust = "#11111b",
return {
  -- START Custom default highlight groups
  CSBorder1 = { fg = colors.surface1, bg = "none" },
  CSBorder2 = { fg = colors.blue, bg = "none" },
  CSCursorLine1 = { fg = colors.text, bg = colors.surface1 },
  CSCursorLine2 = { fg = colors.base, bg = colors.blue },
  ColorColumn = { bg = colors.surface1 },
  Cursor = { bg = colors.overlay0 },
  -- END

  AlphaHeader = { fg = colors.peach },
  AlphaFooter = { fg = colors.peach },
  AlphaShortcut = { fg = colors.red },

  CmpNormal = { bg = "none" },
  CmpFloatBorder = { link = "FloatBorder" },
  CmpCursorLine = { link = "CSCursorLine2" },

  FloatBorder = { link = "CSBorder1" },

  InclineNormal = { bg = colors.surface1 },

  LineNrAbove = { fg = colors.overlay0 },
  LineNrBelow = { link = "LineNrAbove" },
  LuaCommand = { fg = colors.yellow },

  MiniIndentscopeSymbol = { fg = colors.blue },

  NeoTreeGitAdded = { fg = colors.green },
  NeoTreeGitConflict = { fg = colors.red },
  NeoTreeGitDeleted = { fg = colors.red },
  NeoTreeGitIgnored = { fg = colors.overlay0 },
  NeoTreeGitModified = { fg = colors.yellow },
  NeoTreeGitUnstaged = { fg = colors.red },
  NeoTreeGitUntracked = { fg = colors.mauve },
  NeoTreeGitStaged = { fg = colors.green },
  NeoTreeTitleBar = { fg = colors.base, bg = colors.sky },
  NeoTreeFloatBorder = { link = "CSBorder2" },

  NoiceCmdlinePopupTitle = { fg = colors.lavender },
  NoiceCmdlinePopupBorder = { fg = colors.lavender },
  NoiceCmdlineIcon = { fg = colors.lavender },

  TelescopeBorder = { link = "CSBorder1" },
  TelescopeNormal = { fg = colors.overlay2, bg = "none" },
  TelescopeSelection = { link = "CSCursorLine1" },
  TelescopeTitle = { link = "CSCursorLine2" },
  TelescopePreviewTitle = { fg = colors.base, bg = colors.mauve },
  TelescopePromptTitle = { fg = colors.base, bg = colors.red },
  TelescopePromptNormal = { fg = colors.text },

  TermFloatBorder = { link = "CSBorder2" },

  TreesitterContextBottom = { fg = colors.blue, underline = true },

  WindowPickerStatusLineNC = { fg = colors.red, bg = "none" },
  WinSeparator = { link = "FloatBorder" },
}
