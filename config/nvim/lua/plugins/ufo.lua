return {
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "kevinhwang91/promise-async",
    },
    init = function()
      require("lib.utils").keymap.load("ufo")
    end,
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
      end,
    },
  },
}
