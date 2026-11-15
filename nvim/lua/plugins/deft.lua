-- Deft: Deft-style list of markdown notes (fzf-lua picker). Local plugin, code in deft.nvim/lua/deft/init.lua.
return {
  name = "deft",
  dir = vim.fn.stdpath("config") .. "/deft.nvim",
  dependencies = { "ibhagwan/fzf-lua" },
  keys = {
    {
      "<leader>fd",
      function()
        require("deft").open_file_dir()
      end,
      desc = "Deft notes (file's folder)",
    },
    {
      "<leader>fD",
      function()
        require("deft").pick_folder()
      end,
      desc = "Deft notes (pick folder)",
    },
  },
}
