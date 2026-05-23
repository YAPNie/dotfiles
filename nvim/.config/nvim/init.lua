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

-- Set Colorscheme
-- Schedule applying colorscheme because there is no guarantee that
-- the colorscheme will be loaded before applying,
-- but this method will lead to blinking on startup
vim.schedule(function()
	vim.cmd.colorscheme("dayfox")
end)
