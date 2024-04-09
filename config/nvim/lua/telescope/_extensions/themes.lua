local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
-- local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")

local function switcher(opts)
  local function reload_theme(name)
    vim.cmd.colorscheme(name)
  end

  local function save_theme(name)
    local new_content

    -- Read config file and create new content with new theme
    local config_path = vim.fn.stdpath("config") .. opts.config_path
    local file_read = io.open(config_path, "r")
    if file_read then
      local current_theme = require("lib.utils").current_theme()
      local old = 'theme = "' .. current_theme .. '"'
      local new = 'theme = "' .. name .. '"'
      local added_pattern = string.gsub(old, "-", "%%-")
      new_content = file_read:read("*all"):gsub(added_pattern, new)
      file_read:close()
    end

    -- Write new content
    local file_write = io.open(config_path, "w")
    if file_write then
      file_write:write(new_content)
      file_write:close()
    end
  end

  local colors = vim.fn.getcompletion("", "color")
  -- local bufnr = vim.api.nvim_get_current_buf()

  -- local previewer = previewers.new_buffer_previewer({
  --   define_preview = function(self, _)
  --     -- Add content
  --     local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  --     vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
  --
  --     -- Add syntax highlighting in previewer
  --     local ft = (vim.filetype.match({ buf = bufnr }) or "diff"):match("%w+")
  --     require("telescope.previewers.utils").highlighter(self.state.bufnr, ft)
  --   end,
  -- })

  local picker = pickers.new(opts, {
    prompt_title = "󱥚 Find Theme",
    previewer = false,
    finder = finders.new_table(colors),
    sorter = sorters.get_generic_fuzzy_sorter(opts),
    sorting_strategy = "ascending",
    attach_mappings = function(prompt_bufnr, _)
      -- Reload theme while typing
      vim.schedule(function()
        vim.api.nvim_create_autocmd("TextChangedI", {
          buffer = prompt_bufnr,
          callback = function()
            if action_state.get_selected_entry() then
              reload_theme(action_state.get_selected_entry()[1])
            end
          end,
        })
      end)

      -- Reload theme on cycling
      actions.move_selection_previous:replace(function()
        action_set.shift_selection(prompt_bufnr, -1)
        reload_theme(action_state.get_selected_entry()[1])
      end)
      actions.move_selection_next:replace(function()
        action_set.shift_selection(prompt_bufnr, 1)
        reload_theme(action_state.get_selected_entry()[1])
      end)

      -- Save theme on enter
      actions.select_default:replace(function()
        if action_state.get_selected_entry() then
          actions.close(prompt_bufnr)
          save_theme(action_state.get_selected_entry()[1])
        end
      end)

      return true
    end,
  })

  picker:find()
end

local default_opts = {
  config_path = "lua/core/config.lua",
}
local opts = {}

return require("telescope").register_extension({
  setup = function(themes_opts)
    opts = vim.tbl_extend("force", default_opts, themes_opts or {})
  end,
  exports = {
    themes = function()
      -- switcher(opts)
      switcher(require("telescope.themes").get_dropdown(opts))
    end,
  },
})
