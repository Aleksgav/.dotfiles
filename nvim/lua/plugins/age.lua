return {
  "abhinandh-s/age.nvim",
  cmd = { "Age" },
  config = function()
    require("age").setup({
      -- will remove the original file after encrypting.
      encrypt_and_del = true, -- default = false
      key_file = vim.fn.expand("~/.config/age/keys.txt"),
    })
  end,
}
