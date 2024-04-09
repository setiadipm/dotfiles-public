local M = {}

M.cmp_ui = {
  icons = true,
  lspkind_text = true,
  style = "default", -- default | atom
}

local field_arrangement = {
  atom = { "kind", "abbr", "menu" },
}

M.cmp_ui.formatting_style = {
  -- default fields order i.e completion word + item.kind + item.kind icons
  fields = field_arrangement[M.cmp_ui.style] or { "abbr", "kind", "menu" },

  format = function(_, item)
    local icons = require("lib.icons").lspkind
    local icon = (M.cmp_ui.icons and icons[item.kind]) or ""

    if M.cmp_ui.style == "atom" then
      icon = " " .. icon .. " "
      item.menu = M.cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
      item.kind = icon
    else
      icon = M.cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
      item.kind = string.format("%s %s", icon, M.cmp_ui.lspkind_text and item.kind or "")
    end

    return item
  end,
}

M.theme = {
  current = function()
    local status, config = pcall(require, "core.config")
    if status then
      return config.ui.theme
    else
      return "habamax"
    end
  end,

  is_transparent = function()
    local status, config = pcall(require, "core.config")
    if status then
      return config.ui.transparent
    else
      return false
    end
  end,

  load = function()
    local theme = M.theme.current()
    vim.cmd.colorscheme(theme)
  end,
}

local def_options = { noremap = true, silent = true }

local function load_config()
  local mappings = {}
  local mapping_path = vim.api.nvim_get_runtime_file("lua/core/mappings.lua", false)[1]

  if mapping_path then
    mappings = dofile(mapping_path)
  end

  return mappings
end

M.keymap = {
  set = function(mode, lhs, rhs, opts)
    local options = vim.tbl_extend("force", def_options, opts or {})
    vim.keymap.set(mode, lhs, rhs, options)
  end,

  load = function(section, mapping_opts)
    local mappings = load_config()

    if type(section) == "string" then
      mappings = mappings[section]
    end

    for _, mapping in pairs(mappings) do
      local mode = mapping[1]
      local lhs = mapping[2]
      local rhs = mapping[3]
      local opts = vim.tbl_extend("force", mapping_opts or {}, mapping[4] or {})
      M.keymap.set(mode, lhs, rhs, opts)
    end
  end,
}

M.load_mappings = function(section, mapping_opts)
  local mappings = load_config()

  if type(section) == "string" then
    mappings = mappings[section]
  end

  for _, mapping in pairs(mappings) do
    local mode = mapping[1]
    local lhs = mapping[2]
    local rhs = mapping[3]
    local opts = vim.tbl_extend("force", mapping_opts or {}, mapping[4] or {})
    M.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
