return {
  "coffebar/neovim-project",
  opts = {
    projects = {
      "~/projects/*/*",
      "~/projects/*",
      "~/.config/*",
      "~/work_projects/*",
    },
    picker = {
      type = "fzf-lua", -- one of "telescope", "fzf-lua", or "snacks"
    },
    last_session_on_startup = false,
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    -- no picker listed: picker.type (fzf-lua) is required on first use; listing it would load it at startup
    { "Shatur/neovim-session-manager" },
  },
  lazy = false,
  priority = 100,
}
