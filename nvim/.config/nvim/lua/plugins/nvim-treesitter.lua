return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
    branch = "master",
	lazy = false, -- load on startup to mitigate loading
	build = ":TSUpdate",
	config = function()
		-- Configure compiler flags for safe offline transfer between different CPUs
		local require_ok, ts_install = pcall(require, "nvim-treesitter.install")
		if require_ok then
			ts_install.compilers = { "gcc" }
			ts_install.c_flags = '-O2 -Wall -fPIC -mtune="generic"'
			ts_install.cpp_flags = '-O2 -Wall -fPIC -mtune="generic"'
		end
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"ruby",
				"vim",
				"vimdoc",
			},
			-- Autoinstall languages that are not installed:
            -- 'true' = enable, 'false' = disable
			auto_install = false,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		})
	end,
	-- There are additional nvim-treesitter modules that you can use to interact
	-- with nvim-treesitter. You should go explore a few and see what interests you:
	--
	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
