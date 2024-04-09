local utils = require("lib.utils")

require("core.options")

require("core.autocmds")

require("core.lazy-nvim")

utils.theme.load()

utils.keymap.load("default")
