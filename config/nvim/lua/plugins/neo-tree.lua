return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
    init = function()
      require("lib.utils").keymap.load("neotree")
    end,
    opts = {
      popup_border_style = "rounded",
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = "✚",
            deleted = "✖",
            modified = "",
            renamed = "󰁕",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "🖉",
            staged = "",
            conflict = "",
          },
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
      sort_case_insensitive = true,
      window = {
        position = "float",
        width = 30,
        mappings = {
          ["c"] = {
            "copy",
            config = {
              show_path = "relative",
            },
          },
          ["m"] = {
            "move",
            config = {
              show_path = "relative",
            },
          },
          ["<CR>"] = "open_with_window_picker",
          ["S"] = "split_with_window_picker",
          ["s"] = "vsplit_with_window_picker",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    opts = {
      selection_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      filter_rules = {
        autoselect_one = true,
        include_current_win = false,
      },
    },
  },
}
