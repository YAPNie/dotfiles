return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp", -- для связи LSP с автокомплитом
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Хоткеи для LSP (через LspAttach — событие подключения LSP к буферу)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
				end

				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
				map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- Форматирование при сохранении (только для ruff)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.name == "ruff" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = event.buf,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})

		-- ---- Настройка серверов через новый API vim.lsp.config ----

		-- Для Python (типы, автокомплит, навигация)
		vim.lsp.config.pyright = {
			settings = {
				pyright = {
					disableOrganizeImports = true, -- сортировку импортов делает ruff
				},
				python = {
					analysis = {
						ignore = { "*" }, -- проверку импортов тоже делает ruff
					},
				},
			},
		}

		-- Для Python (линтинг + форматирование)
		vim.lsp.config.ruff = {}

		-- Для Lua
		vim.lsp.config.lua_ls = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
				},
			},
		}

		-- Включить все серверы
		vim.lsp.enable({ "pyright", "ruff", "lua_ls" })
	end,
}
