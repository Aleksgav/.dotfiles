return {
  "mason-org/mason.nvim",
  opts = {
    ui = {
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
    },
    ensure_installed = {
      "stylua",
      "selene",
      "luacheck",
      "shellcheck",
      "shfmt",
      "tailwindcss-language-server",
      "typescript-language-server",
      "css-lsp",
    },
  },
}
