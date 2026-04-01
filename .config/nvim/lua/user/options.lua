-- theme
function Transparent(color)
color = color or "gruvbox"
 vim.cmd.colorscheme(color)
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
 vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
Transparent()

vim.opt.termguicolors=true

--options 
vim.opt.clipboard=unnamedplus 

vim.opt.number=true
vim.opt.relativenumber=true

vim.opt.autoindent=true
vim.opt.tabstop=4
vim.opt.expandtab=true
vim.opt.shiftwidth=4
