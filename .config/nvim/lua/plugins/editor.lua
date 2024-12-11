vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.undofile = true

vim.o.number = true
vim.o.relativenumber = true

vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("lazy_automatic_update", { clear = true }),
  callback = function()
    if require("lazy.status").has_updates then
      require("lazy").update({ show = false })
    end
  end,
})

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

      require("ibl").setup({
        indent = { highlight = highlight },
        exclude = {
          filetypes = {
            "dashboard",
          },
        },
      })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      require("fzf-lua").setup({})

      vim.keymap.set("n", "<Leader>fb", require("fzf-lua").buffers, { desc = "fzf buffers" })
      vim.keymap.set("n", "<Leader>ff", require("fzf-lua").files, { desc = "fzf files" })
      vim.keymap.set("n", "<Leader>fl", require("fzf-lua").lines, { desc = "fzf lines" })
      vim.keymap.set("n", "<Leader>ft", require("fzf-lua").tabs, { desc = "fzf tabs" })
      vim.keymap.set("n", "<Leader>fp", require("fzf-lua").live_grep, { desc = "fzf patterns" })
      vim.keymap.set("n", "<Leader>fs", require("fzf-lua").lsp_workspace_symbols, { desc = "fzf symbols" })
    end,
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
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = {
      config = {
        project = { action = function() vim.cmd("FzfLua files") end },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    opts = {},
  },
}
