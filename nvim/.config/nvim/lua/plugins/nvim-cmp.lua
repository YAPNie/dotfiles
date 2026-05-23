return {
	-- Autocompletion engine
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" }, -- загружается и при `:`, и при i
	dependencies = {
		-- Sources (откуда брать варианты)
		"hrsh7th/cmp-nvim-lsp", -- подсказки от LSP
		"hrsh7th/cmp-buffer", -- подсказки из открытых буферов
		"hrsh7th/cmp-path", -- подсказки путей (при наборе / или ~)
		"hrsh7th/cmp-cmdline", -- подсказки для командной строки (:)

		-- Snippet engine (нужен для LSP-подсказок с шаблонами)
		{ "L3MON4D3/LuaSnip", dependencies = { "saadparwaiz1/cmp_luasnip" } },
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- Enter = подтвердить выбранный вариант
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				-- Tab = выбрать следующий вариант
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				-- Ctrl+Space = принудительно открыть меню
				["<C-Space>"] = cmp.mapping.complete(),
				-- Ctrl+u / Ctrl+d = листать документацию
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- подсказки от LSP
				{ name = "luasnip" }, -- сниппеты
			}, {
				{ name = "buffer" }, -- слова из открытых файлов
				{ name = "path" }, -- пути к файлам
			}),
			-- Внешний вид (без Nerd Font)
			formatting = {
				format = function(entry, vim_item)
					-- Показываем источник подсказки в скобках
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snip]",
						buffer = "[Buf]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
		})

		-- Подсказки для командной строки (:)
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "cmdline" }, -- команды Vim
				{ name = "path" }, -- пути
			},
		})

		-- Подсказки для поиска (/)
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" }, -- слова из буфера
			},
		})
	end,
}
