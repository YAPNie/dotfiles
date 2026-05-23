-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- core must load before plugins
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- bootstrap + lazy setup (should be last)
require("config.lazy")

--
vim.cmd.colorscheme("dayfox")
