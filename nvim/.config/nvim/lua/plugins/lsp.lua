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
					local augroup = "format-ruff-" .. event.buf
					-- Используем уникальную группу для каждого буфера
					local augroup = "format-ruff-" .. event.buf
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = event.buf,
						group = vim.api.nvim_create_augroup(augroup, { clear = true }),
						callback = function()
							vim.lsp.buf.format({ name = "ruff", async = false })
						end,
					})
				end
			end,
		})

		-- Настройка серверов через lspconfig (проверенный способ)
		local lspconfig = require("lspconfig")
		-- Python: pyright (типы, автокомплит)
		lspconfig.pyright.setup({
			settings = {
				pyright = {
					disableOrganizeImports = true, -- это делает ruff
				},
				python = {
					analysis = {
						ignore = { "*" }, -- проверку делает ruff
					},
				},
			},
		})
		-- Python: ruff (линтинг + форматирование)
		lspconfig.ruff.setup({})
		-- Lua
		lspconfig.lua_ls.setup({
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
		})
	end,
}
