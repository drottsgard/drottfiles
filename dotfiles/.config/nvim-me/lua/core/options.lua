-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Status column
vim.opt.statuscolumn = "%s %=%#CursorLineNr#%{v:relnum ? '' : v:lnum}%#LineNr#%{v:relnum ? v:relnum : ''} "
