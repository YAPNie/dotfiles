return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			-- Auto change colorscheme
			theme = "auto",
			-- Set Section separators to usual symbols
			section_separators = { left = "", right = "" },
			component_separators = { left = "|", right = "|" },
			-- Enable/disable icons based on Nerd Font availability
			icons_enabled = vim.g.have_nerd_font,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{
					-- Branch name source = 'mini.git'
					"branch",
					source = function()
						-- Get current branch name from 'mini.git'
						return vim.b.minigit_summary and vim.b.minigit_summary.head_name or ""
					end,
				},
				{
					"diff",
					source = function()
						-- Check whether mini.diff is active in the current buffer
						local summary = vim.b.minidiff_summary
						if not summary then
							return nil
						end
						-- Return table with number of changes in lualine format
						return {
							added = summary.add,
							modified = summary.change,
							removed = summary.delete,
						}
					end,
					-- Override default colored blocks with classic text characters
					symbols = { added = "+", modified = "|", removed = "-" },
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = {
						error = "E:",
						warn = "W:",
						info = "I:",
						hint = "H:",
					},
				},
			},
			lualine_c = { "filename" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	},
}
