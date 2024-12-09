vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.g.mapleader = " "

return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "pocco81/auto-save.nvim",
    config = true,
  },
}
