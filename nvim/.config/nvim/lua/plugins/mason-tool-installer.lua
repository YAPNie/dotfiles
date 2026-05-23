return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim" },
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"ruff", -- Python Linter, Formatter, Sorter (written on Rust)
				-- "black", -- Python Formatter (written on Python)
				-- "isort", -- Python import sorter (written on TypeScript)
				"pyright", -- Python LSP (Microsoft) (written on TypeScript)
				"lua-language-server", -- Lua LSP
				-- "solargraph",
				-- "rubocop",
			},
			auto_update = false,
		})
	end,
}
