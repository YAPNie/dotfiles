return {
	-- Collection of various small independent plugins/modules
	"nvim-mini/mini.nvim",
	config = function()
		-- Manage icons and mock older 'nvim-web-devicons' plugin
		--
		-- - Automatically enables system-wide devicons for which-key, etc.
		-- - No additional fonts required unless you choose to use a Nerd Font
		require("mini.icons").setup({
			-- 'default' uses glyps, 'ascii' uses text only
			style = vim.g.have_nerd_font and "default" or "ascii",
		})
		require("mini.icons").mock_nvim_web_devicons()

		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({
			n_lines = 500,
		})

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Integration with Git (commands, statuses, history)
		require("mini.git").setup()

		-- Show diff (diff hunks) on the sign column.
		-- If `view` is not defined and line numbers are enabled,
		-- the line numbers themselves will be colored.
		-- If `view.style = "sign"` is used but `signs` are not defined,
		-- solid colored blocks (squares) will be displayed on the signcolumn.
		require("mini.diff").setup({
			view = {
				-- Display signs in the signcolumn
				-- instead of colorizing line numbers
				style = "sign",
				-- Override default colored blocks with classic text characters
				signs = { add = "+", change = "|", delete = "-" },
			},
		})

		-- Simple and easy statusline. [DISABLED, lualine is used instead]
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		-- local statusline = require("mini.statusline")
		-- set use_icons to true if you have a Nerd Font
		-- statusline.setup({
		-- use_icons = vim.g.have_nerd_font,
		-- })

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		-- statusline.section_location = function()
		-- 	return "%2l:%-2v"
		-- end

		-- File explorer with text-editing capabilities
		--
		--  - Navigate folders using a cascade of floating windows
		--  - Create, delete, and rename files/directories as regular text
		--  - Save the buffer (:w) to apply changes to the file system
		require("mini.files").setup()

		-- Open in dir of currently opened file
		vim.keymap.set("n", "<leader>fe", function()
			require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
		end, { desc = "[f]ile [e]xplore (current file directory)" })

		-- Open in a project folder
		vim.keymap.set("n", "<leader>fE", function()
			require("mini.files").open(vim.uv.cwd(), true)
		end, { desc = "[f]ile [E]xplore (project root)" })

		-- ... and there is more!
		--  Check out: https://github.com/nvim-mini/mini.nvim
	end,
}
