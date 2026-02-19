-- Set leader key before anything else (required before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core modules
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Load lazy.nvim
require("config.lazy")
