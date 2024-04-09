return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      disable_filetype = { "TelescopePrompt" },
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      -- fast_wrap = {
      --   map = "<M-e>",
      --   chars = { "{", "[", "(", '"', "'" },
      --   pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      --   offset = 0,
      --   end_key = "$",
      --   keys = "qwertyuiopzxcvbnmasdfghjkl",
      --   check_comma = true,
      --   highlight = "PmenuSel",
      --   highlight_grey = "LineNr",
      -- },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
}
