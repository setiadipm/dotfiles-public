local p = require("rose-pine.palette")

-- List of highlight groups
-- https://github.com/rose-pine/neovim/blob/main/lua/rose-pine.lua
-- Palette
-- https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/palette.lua
-- _nc = "#1f1d30",
-- base = "#232136",
-- surface = "#2a273f",
-- overlay = "#393552",
-- muted = "#6e6a86",
-- subtle = "#908caa",
-- text = "#e0def4",
-- love = "#eb6f92",
-- gold = "#f6c177",
-- rose = "#ea9a97",
-- pine = "#3e8fb0",
-- foam = "#9ccfd8",
-- iris = "#c4a7e7",
-- highlight_low = "#2a283e",
-- highlight_med = "#44415a",
-- highlight_high = "#56526e",
-- none = "NONE",
return {
  -- START Custom default highlight groups
  CSBorder1 = { fg = p.highlight_med, bg = "none" },
  CSBorder2 = { fg = p.pine, bg = "none" },
  CSCursorLine1 = { fg = p.text, bg = p.highlight_med },
  CSCursorLine2 = { fg = p.base, bg = p.rose },
  ColorColumn = { bg = p.highlight_med },
  Cursor = { bg = p.muted },
  -- END

  AlphaHeader = { fg = p.gold },
  AlphaFooter = { fg = p.gold },
  AlphaShortcut = { fg = p.love },

  CmpNormal = { bg = "none" },
  CmpFloatBorder = { link = "FloatBorder" },
  CmpCursorLine = { link = "CSCursorLine2" },

  FloatBorder = { link = "CSBorder1" },

  InclineNormal = { bg = p.highlight_med },

  LineNrAbove = { fg = p.muted },
  LineNrBelow = { link = "LineNrAbove" },
  LuaCommand = { fg = p.gold },

  MiniIndentscopeSymbol = { fg = p.pine },

  NeoTreeGitAdded = { fg = p.foam },
  NeoTreeGitConflict = { fg = p.iris },
  NeoTreeGitDeleted = { fg = p.love },
  NeoTreeGitIgnored = { fg = p.muted },
  NeoTreeGitModified = { fg = p.rose },
  NeoTreeGitUnstaged = { fg = p.love },
  NeoTreeGitUntracked = { fg = p.subtle },
  NeoTreeGitStaged = { fg = p.foam },
  NeoTreeTitleBar = { fg = p.base, bg = p.foam },
  NeoTreeFloatBorder = { link = "CSBorder2" },

  NoiceCmdlinePopupTitle = { fg = p.foam },
  NoiceCmdlinePopupBorder = { fg = p.foam },
  NoiceCmdlineIcon = { fg = p.foam },

  TelescopeBorder = { link = "CSBorder1" },
  TelescopeNormal = { fg = p.subtle, bg = "none" },
  TelescopeSelection = { link = "CSCursorLine1" },
  TelescopeTitle = { link = "CSCursorLine2" },
  TelescopePreviewTitle = { fg = p.base, bg = p.iris },
  TelescopePromptTitle = { fg = p.base, bg = p.love },
  TelescopePromptNormal = { fg = p.text },

  TermFloatBorder = { link = "CSBorder2" },

  TreesitterContextBottom = { fg = p.pine, underline = true },

  WindowPickerStatusLineNC = { fg = p.love, bg = "none" },
  WinSeparator = { link = "FloatBorder" },
}
