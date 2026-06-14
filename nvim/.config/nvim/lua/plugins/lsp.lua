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
					-- Используем уникальную группу для каждого буфера
					local augroup = "format-ruff-" .. event.buf
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = event.buf,
						group = vim.api.nvim_create_augroup(augroup, { clear = true }),
						callback = function()
							-- 1. Сортировка импортов (синхронно)
							vim.lsp.buf.code_action({
								context = { only = { "source.organizeImports" } },
								apply = true,
							})
							-- 2. Форматирование кода (синхронно)
							vim.lsp.buf.format({ name = "ruff", async = false })
						end,
					})
				end
			end,
		})

		-- НАСТРОЙКА СЕРВЕРОВ ЧЕРЕЗ НОВЫЙ API (vim.lsp.config)
		-- Это единственный правильный способ для Neovim 0.11+
		-- Без предупреждений, без deprecated
		vim.lsp.config.pyright = {
			root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
			settings = {
				pyright = {
					disableOrganizeImports = true,
				},
				python = {
					analysis = {
						ignore = { "*" },
					},
				},
			},
		}
		vim.lsp.config.ruff = {
			root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
		}
		vim.lsp.config.lua_ls = {
			root_markers = { ".luarc.json", ".luacheckrc", ".git" },
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = {
							vim.fn.expand("$VIMRUNTIME/lua"),
							vim.fn.expand("$VIMRUNTIME/lua/vim"),
						},
						checkThirdParty = false,
					},
				},
			},
		}
		-- Включаем серверы
		vim.lsp.enable({ "pyright", "ruff", "lua_ls" })
	end,
}
