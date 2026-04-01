require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim",                                    import = "lazyvim.plugins" },

    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {},
        auto_install = false,
      },
    },

    { "mason-org/mason.nvim",                               enabled = false },
    { "mason-org/mason-lspconfig.nvim",                     enabled = false },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.json" },

    { import = "plugins" }
  },
  performance = {
    reset_packpath = false,
  },
})
