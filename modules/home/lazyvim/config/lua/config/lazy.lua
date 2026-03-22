require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim",                import = "lazyvim.plugins" },

    -- TREESITTER KONFIGURATION
    {
      "nvim-treesitter/nvim-treesitter",
      -- Wir nutzen "dir", um auf den Nix-Pfad zu verweisen,
      -- ODER wir lassen LazyVim einfach das Framework verwalten:
      opts = {
        ensure_installed = {},
        auto_install = false,
      },
      -- WICHTIG: Entferne das manuelle require("nvim-treesitter.configs")
      -- aus dem 'config' Feld, wenn es Fehler wirft.
      -- LazyVim macht das automatisch richtig.
    },

    { "mason-org/mason.nvim",           enabled = false },
    { "mason-org/mason-lspconfig.nvim", enabled = false },
    { import = "plugins" },
  },
  performance = {
    -- Das ist der entscheidende Schalter für NixOS!
    -- Er sorgt dafür, dass die Plugins aus /nix/store im Pfad bleiben.
    reset_packpath = false,
  },
})
