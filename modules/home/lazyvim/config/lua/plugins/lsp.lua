return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        nixd = {
          settings = {
            nixd = {
              formatting = {
                command = { "nixpkgs-fmt" },
              },
              options = {
                nixos = {
                  expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.default.options',
                },
              },
            },
          },
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              procMacro = {
                enable = false,
              },
              diagnostics = {
                disabled = { "unresolved-proc-macro" },
              },
            },
          },
        },
      })
    end,
  },
  {
    "whonore/Coqtail",
    ft = { "coq" },
    init = function()
      vim.g.coqtail_auto_start = 1
    end,
  },
}
