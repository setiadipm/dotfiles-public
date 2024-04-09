local lsps = {
  angularls = { package = "angular-language-server" },
  docker_compose_language_service = { package = "docker-compose-language-service" },
  dockerls = { package = "dockerfile-language-server" },
  eslint = { package = "eslint-lsp" },
  gopls = {
    package = "gopls",
    opts = {
      settings = {
        gopls = {
          analyses = {
            fieldalignment = false,
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          hints = {
            constantValues = true,
            parametereNames = true,
            rangeVariableTypes = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
        },
      },
    },
  },
  html = { package = "html-lsp" },
  intelephense = { package = "intelephense" },
  lua_ls = {
    package = "lua-language-server",
    opts = {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    },
  },
  tsserver = { package = "typescript-language-server" },
  tailwindcss = { package = "tailwindcss-language-server" },
  templ = { package = "templ" },
}

local linters = {
  "eslint_d",
  "golangci-lint",
}

local formatters = {
  "gofumpt",
  "goimports-reviser",
  "php-cs-fixer",
  "prettierd",
  "shfmt",
  "stylua",
}

return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    init = function()
      require("lib.utils").keymap.load("mason")
    end,
    config = function()
      require("mason").setup()

      local registry = require("mason-registry")

      local ensure_installed = {}
      for _, value in ipairs(linters) do
        table.insert(ensure_installed, value)
      end
      for _, value in ipairs(formatters) do
        table.insert(ensure_installed, value)
      end
      for _, lspinfo in pairs(lsps) do
        table.insert(ensure_installed, lspinfo.package)
      end

      for _, tool_name in ipairs(ensure_installed) do
        if not registry.is_installed(tool_name) then
          vim.cmd("MasonInstall " .. tool_name)
        end
      end

      -- Custom cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = ensure_installed
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      require("lib.utils").keymap.load("lspconfig")
    end,
    config = function()
      -- Follow installation needed for each server in link below:
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#docker_compose_language_service
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        -- Somehow prevent multiple formattings applied at the same time (no wiggle on the screen)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        require("lib.utils").keymap.load("lsp", { buffer = bufnr })
      end

      for lspname, lspinfo in pairs(lsps) do
        local opts = vim.tbl_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
        }, lspinfo.opts or {})

        lspconfig[lspname].setup(opts)
      end
    end,
  },
}
