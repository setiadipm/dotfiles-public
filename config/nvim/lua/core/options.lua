local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

-- Disable codeium default keybindings
g.codeium_disable_bindings = 1

-- Configure clipboard
local has_win32yank = vim.fn.executable("win32yank.exe") == 1
if has_win32yank then
  g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end

-- Configure shell
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  local handle = io.popen("bash --version")
  if handle then
    local result = handle:read("*a")
    handle:close()

    if string.match(result, "GNU bash") then
      opt.shellcmdflag = "-c -l"
      opt.shellquote = ""
      opt.shellxquote = ""
    else
      opt.shell = "cmd"
    end
  else
    opt.shell = "cmd"
  end
end

-- Line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.numberwidth = 2
opt.relativenumber = true -- show relative line numbers
opt.ruler = false

-- Tabs & indentation
opt.autoindent = true -- copy indent from current line when starting new one
opt.expandtab = true -- expand tab to spaces
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.smartindent = true -- insert indents automatically
opt.softtabstop = 2 -- 2 spaces for pressing tab
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)

-- Behavior
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.iskeyword:append("-") -- consider string-string as whole word
opt.mouse = "" -- disable mouse
opt.undofile = true -- enable persistent undo
opt.whichwrap:append("<>[]hl") -- go to prev/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line
opt.ttimeoutlen = 10 -- reduce wait for a key code sequence to complete, default is 50

-- Search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- Appearance
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.cursorline = true -- highlight the current cursor line
opt.colorcolumn = "120" -- show a column at certain characters
opt.fillchars = { eob = " " } -- show a special character at the end of each line
-- opt.laststatus = 2 -- show statusline per split window
opt.laststatus = 3 -- show statuline for all windows
opt.scrolloff = 15 -- min line below and above cursor
opt.showmode = false -- dont show mode since we have statusline
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.termguicolors = true -- True color support
opt.wrap = false -- disable line wrapping

-- Split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Folding
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Register filetype
vim.filetype.add({ extension = { templ = "templ" } })
