local M = {}

M.default = {
  -- { "n", "<leader>pv", ":Ex<CR>" }, -- Open netrw

  { "n", "<ESC>", ":nohl<CR>", { desc = "Escape and clear hlsearch" } },

  { { "n", "v" }, "<leader>d", '"_d', { desc = "Delete no buffer" } },
  -- Don't copy the replaced text after pasting in visual mode
  -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
  { "x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste no buffer" } },
  -- { { "n", "x" }, "p", '"0p', { desc = "Paste no buffer" } },
  { { "n", "x" }, "gw", "*N", { desc = "Search word under cursor" } },

  -- Lazy command
  { "n", "<leader>ll", ":Lazy<CR>", { desc = "Open Lazy" } },
  { "n", "<leader>lu", ":Lazy update<CR>", { desc = "Lazy update" } },

  -- Autoformat on save
  { "n", "<leader>tc", ":ToggleCodeFormat<CR>", { desc = "Toggle auto code formatting on save" } },
  { "n", "<leader>stc", ":StatusCodeFormat<CR>", { desc = "Print status auto code formatting" } },

  -- Window management
  { "n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" } },
  { "n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" } },
  { "n", "<leader>se", "<C-w>=", { desc = "Equal split size" } },
  { "n", "<leader>sx", ":close<CR>", { desc = "Close current split" } },
  { "n", "<C-k>", "<C-w>k", { desc = "Go to upper split" } },
  { "n", "<C-j>", "<C-w>j", { desc = "Go to lower split" } },
  { "n", "<C-h>", "<C-w>h", { desc = "Go to left split" } },
  { "n", "<C-l>", "<C-w>l", { desc = "Go to right split" } },

  -- Navigation
  { "n", "<C-u>", "<C-u>zz", { desc = "Page up" } },
  { "n", "<C-d>", "<C-d>zz", { desc = "Page down" } },
  { "n", "<A-k>", "5kzz", { desc = "Scroll up" } },
  { "n", "<A-j>", "5jzz", { desc = "Scroll down" } },

  -- Editing
  { "i", "<C-k>", "<Up>", { desc = "Move up" } },
  { "i", "<C-j>", "<Down>", { desc = "Move down" } },
  { "i", "<C-h>", "<Left>", { desc = "Move left" } },
  { "i", "<C-l>", "<Right>", { desc = "Move right" } },
  -- { "n", "<A-k>", ":m .-2<CR>==", { desc = "Move up" } },
  -- { "n", "<A-j>", ":m .+1<CR>==", { desc = "Move down" } },
  { "i", "<A-k>", "<ESC>:m .-2<CR>==gi", { desc = "Move up" } },
  { "i", "<A-j>", "<ESC>:m .+1<CR>==gi", { desc = "Move down" } },
  { "v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move up" } },
  { "v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move down" } },

  -- Better indenting
  { "v", "<", "<gv" },
  { "v", ">", ">gv" },

  -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
  -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
  -- empty mode is same as using <cmd> :map
  -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
  { { "n", "x" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, desc = "Move up" } },
  { { "n", "x" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, desc = "Move down" } },

  -- Disable keys
  { "n", "<up>", ":echoerr 'Umm, use k instead'<CR>" }, -- Prevent arrow up
  { "n", "<down>", ":echoerr 'Umm, use j instead'<CR>" }, -- Prevent arrow down
  { "n", "<left>", ":echoerr 'Umm, use h instead'<CR>" }, -- Prevent arrow left
  { "n", "<right>", ":echoerr 'Umm, use l instead'<CR>" }, -- Prevent arrow right
  { "v", "<up>", ":echoerr 'Umm, use k instead'<CR>" }, -- Prevent arrow up
  { "v", "<down>", ":echoerr 'Umm, use j instead'<CR>" }, -- Prevent arrow down
  { "v", "<left>", ":echoerr 'Umm, use h instead'<CR>" }, -- Prevent arrow left
  { "v", "<right>", ":echoerr 'Umm, use l instead'<CR>" }, -- Prevent arrow right
}

M.codeium = {
  {
    "i",
    "<C-y>",
    function()
      return vim.fn["codeium#Accept"]()
    end,
    { expr = true, desc = "Accept Codeium snippet" },
  },
}

M.fugitive = {
  { "n", "<leader>gg", ":Git<CR>:MaximizerToggle<CR>", { desc = "Git (Full screen)" } },
  { "n", "<leader>gv", ":Gvdiff<CR>", { desc = "Git diff vertical" } },
}

M.gitsigns = {
  { "n", "[c", ":Gitsigns prev_hunk<CR>", { desc = "Prev hunk" } },
  { "n", "]c", ":Gitsigns next_hunk<CR>", { desc = "Next hunk" } },
  { "n", "<leader>gd", ":Gitsigns toggle_deleted<CR>", { desc = "Toggle deleted" } },
  { "n", "<leader>gp", ":Gitsigns preview_hunk_inline<CR>", { desc = "Preview hunk" } },
  { "n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" } },
}

M.gopher = {
  { "n", "<leader>gaj", ":GoTagAdd json<CR>", { desc = "Add json struct tags" } },
  { "n", "<leader>gay", ":GoTagAdd yaml<CR>", { desc = "Add yaml struct tags" } },
  { "n", "<leader>gad", ":GoTagAdd db<CR>", { desc = "Add db struct tags" } },
  { "n", "<leader>gie", ":GoIfErr<CR>", { desc = "Add if err block" } },
}

M.lsp = {
  { "n", "K", ":Lspsaga hover_doc<CR>", { desc = "Lspsaga hover" } },
  { "n", "gd", ":Lspsaga peek_definition<CR>", { desc = "Lspsaga peek definition" } },
  { "n", "gD", ":Lspsaga goto_definition<CR>", { desc = "Lspsaga goto definition" } },
  {
    "n",
    "gi",
    function()
      vim.lsp.buf.implementation()
    end,
    { desc = "LSP implementation" },
  },
  -- {
  --   "n",
  --   "<leader>q",
  --   ":Lspsaga show_workspace_diagnostics ++float<CR>",
  --   { desc = "Telescope show diagnotics" },
  -- },
  { { "n", "v" }, "<leader>ca", ":Lspsaga code_action<CR>", { desc = "Lspsaga code action" } },
  -- {
  --   { "n", "v" },
  --   "<leader>ca",
  --   function()
  --     vim.lsp.buf.code_action()
  --   end,
  --   { desc = "Lspsaga code action" },
  -- },
  { "n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", { desc = "Goto prev diagnostic" } },
  { "n", "]d", ":Lspsaga diagnostic_jump_next<CR>", { desc = "Goto next diagnostic" } },
  {
    "n",
    "<leader>cf",
    function()
      vim.lsp.buf.format({ async = true })
    end,
    { desc = "LSP formatting" },
  },
  {
    "n",
    "<leader>wl",
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    { desc = "List workspace folders" },
  },

  -- { "n", "<leader>wa", vim.lsp.buf.add_workspace_folder },
  -- { "n", "<leader>wr", vim.lsp.buf.remove_workspace_folder },
  -- { "n", "<leader>ls", vim.lsp.buf.signature_help },
  -- { "n", "<leader>D", vim.lsp.buf.type_definition },
  -- { "n", "<leader>ra", vim.lsp.buf.rename },
  -- { "n", "gr", vim.lsp.buf.references },
}

M.lspconfig = {
  { "n", "<leader>cl", ":LspInfo<CR>", { desc = "LSP Info" } },
}

M.mason = {
  { "n", "<leader>cm", ":Mason<CR>", { desc = "Mason" } },
}

M.maximizer = {
  { "n", "<leader>sm", ":MaximizerToggle!<CR>", { desc = "Toggle maximize split" } },
}

M.neotree = {
  -- { "n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle neotree" } },
  { "n", "<leader>e", ":Neotree reveal_force_cwd<CR>", { desc = "Reveal neotree" } },
}

M.noice = {
  { "n", "<leader>nh", ":NoiceHistory<CR>", { desc = "Noice history" } },
}

M.spectre = {
  { "n", "<leader>sr", ":Spectre<CR>", { desc = "Replace in files (Spectre)" } },
}

M.telescope = {
  -- Find
  { "n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files (Root dir)" } },
  { "n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Buffers" } },
  { "n", "<leader>fr", ":Telescope resume<CR>", { desc = "Resume" } },
  -- { "n", "<leader>fw", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Find words in buffer" } },
  { "n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Grep" } },
  { "n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Key maps" } },
  {
    "n",
    "<leader>fs",
    function()
      local builtin = require("telescope.builtin")
      builtin.grep_string({ search = vim.fn.input("Find > ") })
    end,
    { desc = "Find words" },
  },
  -- Diagnostic
  { "n", "<leader>q", ":Telescope diagnostics<CR>", { desc = "Show diagnotics" } },
  -- Git
  { "n", "<leader>gc", ":Telescope git_commits<CR>", { desc = "Show git commits" } },
  { "n", "<leader>gs", ":Telescope git_status<CR>", { desc = "Show git status" } },
  -- Theme
  { "n", "<leader>th", ":Telescope themes<CR>", { desc = "Theme switcher" } },
}

M.tmuxnavigator = {
  { "n", "<C-h>", ":TmuxNavigateLeft<CR>", dec = "Window left" },
  { "n", "<C-j>", ":TmuxNavigateDown<CR>", dec = "Window down" },
  { "n", "<C-k>", ":TmuxNavigateUp<CR>", dec = "Window up" },
  { "n", "<C-l>", ":TmuxNavigateRight<CR>", dec = "Window right" },
}

M.toggleterm = {
  { "n", "<A-i>", ":ToggleTerm direction=float<CR>", { desc = "Toggle float terminal" } },
  { "n", "<A-h>", ":ToggleTerm direction=horizontal size=12<CR>", { desc = "Toggle horizontal terminal" } },
  { "n", "<A-v>", ":ToggleTerm direction=vertical size=40<CR>", { desc = "Toggle vertical terminal" } },

  {
    "t",
    "<A-i>",
    [[<C-\><C-n>:ToggleTerm<CR>]],
    { desc = "Toggle terminal" },
  },
  {
    "t",
    "<A-h>",
    [[<C-\><C-n>:ToggleTerm<CR>]],
    { desc = "Toggle terminal" },
  },
  {
    "t",
    "<A-v>",
    [[<C-\><C-n>:ToggleTerm<CR>]],
    { desc = "Toggle terminal" },
  },
  { "t", "<ESC>", [[<C-\><C-n>]] },
  { "t", "jk", [[<C-\><C-n>]] },
  { "t", "<C-k>", [[:wincmd k<CR>]] },
  { "t", "<C-j>", [[:wincmd j<CR>]] },
  { "t", "<C-h>", [[:wincmd h<CR>]] },
  { "t", "<C-l>", [[:wincmd l<CR>]] },
  { "t", "<C-w>", [[<C-\><C-n><C-w>]] },
}

M.ufo = {
  {
    "n",
    "zR",
    function()
      require("ufo").openAllFolds()
    end,
    { desc = "Open all folds" },
  },
  {
    "n",
    "zM",
    function()
      require("ufo").closeAllFolds()
    end,
    { desc = "Close all folds" },
  },
}

M.wakatime = {
  { "n", "<leader>wt", ":WakaTimeToday<CR>", { desc = "WakaTime today" } },
}

M.whichkey = {
  { "n", "<leader>wk", ":WhichKey<CR>", { desc = "Which-key all keymaps" } },
}

return M
