-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo(
			{ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." } },
			true,
			{}
		)
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = { -- import your plugins
		{
			import = "plugins",
		},
	},
	-- Enable project-local plugin configurations via .lazy.lua file
	local_spec = true,
	-- Disable auto checking for configuration files changing
	change_detection = {
		enabled = false,
        -- disable notification that a configuration file was saved
		notify = false,
	},
	-- LuaRocks/HereRocks
	rocks = {
		-- Force enabling support LuaRocks
		enabled = true,
		-- Force using HereRocks (isolated sandbox for LuaRocks plugins)
		hererocks = true,
	},
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will
		-- use the default lazy.nvim defined Nerd Font icons, otherwise define a
		-- unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "CMD",
			config = "CFG",
			event = "EVENT",
			ft = "FTYPE",
			init = "INIT",
			keys = "KEYS",
			plugin = "PLUGIN",
			runtime = "RUNTIME",
			require = "REQ",
			source = "SOURCE",
			start = "START",
			task = "TASK",
			lazy = "LAZY",
			-- cmd = "⌘",
			-- config = "🛠",
			-- event = "📅",
			-- ft = "📂",
			-- init = "⚙",
			-- keys = "🗝",
			-- plugin = "🔌",
			-- runtime = "💻",
			-- require = "🌙",
			-- source = "📄",
			-- start = "🚀",
			-- task = "📌",
			-- lazy = "💤 ",
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = {
		enabled = false,
	},
})
