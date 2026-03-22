return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Hier aktivieren wir nixd
        nixd = {
          settings = {
            nixd = {
              formatting = {
                command = { "nixpkgs-fmt" }, -- Optional: für automatisches Formatieren
              },
              options = {
                -- Hiermit bekommt nixd Zugriff auf deine System-Optionen (Autocompletion!)
                nixos = {
                  expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.default.options',
                },
              },
            },
          },
        },
      },
    },
  },
}
