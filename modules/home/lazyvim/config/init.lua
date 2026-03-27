require("transparent").setup({
  extra_groups = { "NormalFloat", "NvimTreeNormal" },
})
require("config.lazy")
require("lspconfig").nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" },
      },
    },
  },
})
require("lspconfig").kdl_ls.setup({})
