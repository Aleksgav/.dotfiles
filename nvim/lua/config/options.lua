-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.g.lazyvim_picker = "fzf"

-- loading the ru/en spell files takes ~10ms, so turn spell on right after the first frame
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    vim.go.spell = true
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "" then
        vim.wo[win].spell = true
      end
    end
  end,
})
vim.opt.spelllang = { "ru_ru", "en_us" }

vim.g.lazyvim_picker = "fzf"

vim.filetype.add({
  extension = {
    thor = "thor",
  },
})
vim.treesitter.language.register("ruby", "thor")

vim.opt.conceallevel = 2

-- Undercurl
-- if not working see:
-- https://dev.to/anurag_pramanik/how-to-enable-undercurl-in-neovim-terminal-and-tmux-setup-guide-2ld7
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
