vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.undofile = true

vim.o.number = true
vim.o.relativenumber = true

vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

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
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local highlight = {
        "RainbowLove",
        "RainbowGold",
        "RainbowRose",
        "RainbowPine",
        "RainbowFoam",
        "RainbowIris",
      }

      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        local palette = require("rose-pine.palette")

        vim.api.nvim_set_hl(0, "RainbowLove", { fg = palette.love })
        vim.api.nvim_set_hl(0, "RainbowGold", { fg = palette.gold })
        vim.api.nvim_set_hl(0, "RainbowRose", { fg = palette.rose })
        vim.api.nvim_set_hl(0, "RainbowPine", { fg = palette.pine })
        vim.api.nvim_set_hl(0, "RainbowFoam", { fg = palette.foam })
        vim.api.nvim_set_hl(0, "RainbowIris", { fg = palette.iris })
      end)

      require("ibl").setup({ indent = { highlight = highlight } })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local parsers = require("nvim-treesitter.parsers")

      function _G.treesitter_automatic_parser_setup()
        local lang = parsers.get_buf_lang()
        if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
          vim.schedule_wrap(function()
            vim.cmd("TSInstall " .. lang)
          end)()
        end
      end

      vim.cmd("autocmd FileType * :lua treesitter_automatic_parser_setup()")
    end,
  },
}
