return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")

		local function button(sc, txt, keybind)
			local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

			local opts = {
				position = "center",
				text = txt,
				shortcut = sc,
				cursor = 5,
				width = 36,
				align_shortcut = "right",
				hl = "AlphaButtons",
			}

			if keybind then
				opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
			end

			return {
				type = "button",
				val = txt,
				on_press = function()
					local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
					vim.api.nvim_feedkeys(key, "normal", false)
				end,
				opts = opts,
			}
		end

		-- dynamic header padding
		local fn = vim.fn
		local marginTopPercent = 0.3
		local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

		local options = {

			header = {
				type = "text",
				val = {
					"   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
					"    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
					"          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
					"           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
					"          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
					"   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
					"  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
					" ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
					" ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
					"      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
					"       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
				},
				opts = {
					position = "center",
					hl = "AlphaHeader",
				},
			},

			buttons = {
				type = "group",
				val = {
					button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
					button("SPC f o", "  Recent File  ", ":Telescope oldfiles<CR>"),
					button("SPC f w", "  Find Word  ", ":Telescope live_grep<CR>"),
				},
				opts = {
					spacing = 1,
				},
			},

			headerPaddingTop = { type = "padding", val = headerPadding },
			headerPaddingBottom = { type = "padding", val = 2 },
		}

		alpha.setup({
			layout = {
				options.headerPaddingTop,
				options.header,
				options.headerPaddingBottom,
				options.buttons,
			},
			opts = {},
		})

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
