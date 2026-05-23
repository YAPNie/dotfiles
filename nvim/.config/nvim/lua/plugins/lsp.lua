return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp", -- для связи LSP с автокомплитом
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")

		-- Функция-помощник: добавляет возможности автокомплита к LSP-серверу
		local on_attach = function(client, bufnr)
			-- Включаем автокомплит при подключении LSP
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			client.server_capabilities = vim.tbl_deep_extend("force", client.server_capabilities, capabilities)

			-- Hotkeys for  LSP (работают, когда LSP подключён к буферу)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
			map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
			map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			map("K", vim.lsp.buf.hover, "Hover Documentation")
			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

			-- Форматирование при сохранении (только для ruff)
			if client.name == "ruff" then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end
		end

		-- Настройка LSP-серверов
		local servers = {
			-- Для Python (типы, автокомплит, навигация)
			pyright = {
				settings = {
					pyright = {
						-- Отключаем сортировку импортов в pyright,
						-- это будет делать ruff
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							-- Отключаем проверку импортов в pyright,
							-- это тоже будет делать ruff
							ignore = { "*" },
						},
					},
				},
			},
			-- Для Python (линтинг + форматирование)
			ruff = {},
			-- Для Lua
			lua_ls = {
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
			},
		}

		-- Автоматически настраиваем каждый сервер
		for server_name, server_opts in pairs(servers) do
			lspconfig[server_name].setup({
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = server_opts.settings,
			})
		end
	end,
}
