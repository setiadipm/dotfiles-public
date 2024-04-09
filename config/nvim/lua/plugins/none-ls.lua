return {
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local usercmd = vim.api.nvim_create_user_command

      -- Toggle autoformat
      _G.codeformat_enabled = true

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.fish_indent,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports_reviser,
          -- null_ls.builtins.formatting.golines,
          null_ls.builtins.formatting.phpcsfixer,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.fish,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
              group = augroup,
              buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
              desc = "Code format on save",
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- Check the global variable _G.codeformat_enabled before formatting
                if _G.codeformat_enabled then
                  vim.lsp.buf.format({ bufnr = bufnr })
                end
              end,
            })
          end
        end,
      })

      usercmd("ToggleCodeFormat", function()
        _G.codeformat_enabled = not _G.codeformat_enabled
        vim.cmd("StatusCodeFormat")
      end, {})

      usercmd("StatusCodeFormat", function()
        local status = _G.codeformat_enabled and "ENABLED" or "DISABLED"
        print("auto code formatting on save is now", status)
      end, {})
    end,
  },
}
