return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			-- Автоматически подстраивается под твою цветовую схему
			theme = "auto",
			-- Разделители секций — обычные символы
			section_separators = { left = "", right = "" },
			component_separators = { left = "|", right = "|" },
			-- Отключить иконки (Nerd Font не нужен)
			icons_enabled = vim.g.have_nerd_font,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				"branch",
				"diff",
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
