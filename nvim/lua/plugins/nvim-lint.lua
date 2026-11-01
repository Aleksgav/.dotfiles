-- markdownlint settings: the nearest .markdownlint-cli2.yaml / .markdownlint.yaml above the file,
-- otherwise nvim/default.markdownlint-cli2.yaml
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        prepend_args = {
          "--config",
          function()
            local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
            return vim.fs.find({ ".markdownlint-cli2.yaml", ".markdownlint.yaml" }, { upward = true, path = dir })[1]
              or vim.fn.stdpath("config") .. "/default.markdownlint-cli2.yaml"
          end,
        },
      },
    },
  },
}
