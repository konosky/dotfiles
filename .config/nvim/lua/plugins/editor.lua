vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.undofile = true

vim.g.mapleader = " "

vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })

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
