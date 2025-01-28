return {
"navarasu/onedark.nvim", 
name = "onedark", 
priority = 1000,
config = function()
require("onedark").setup({
style = "deep"})
vim.cmd([[colorscheme onedark]])
end,
}
