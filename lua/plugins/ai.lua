return {
  {
    "zbirenbaum/copilot.lua",
    requires = {
      "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    },
    cmd = "Copilot",
    event = "VeryLazy",
    opts = {},
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
    },
    init = function()
      require("utils.codecompanion_fidget_spinner"):init()
    end,

    opts = {
      language = "Chinese",
    },
    keys = {
      {
        "<leader>cci",
        "<CMD>CodeCompanion<CR>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "CodeCompanion Inline",
      },
      {
        "<leader>ccc",
        "<CMD>CodeCompanionChat<CR> Toggle",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "CodeCompanion Chat Toggle",
      },
      {
        "<leader>ccp",
        "<CMD>CodeCompanionChat Add<CR>",
        mode = { "v" },
        silent = true,
        noremap = true,
        desc = "CodeCompanion Chat Add",
      },
    },
  },
}
