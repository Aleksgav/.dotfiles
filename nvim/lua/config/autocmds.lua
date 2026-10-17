-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Markdown -> PDF auto-preview (pandoc + typst, viewed in sioyek)
local md_pdf = vim.api.nvim_create_augroup("md_pdf_preview", { clear = true })

local function md_pdf_render(buf, on_done)
  local src = vim.api.nvim_buf_get_name(buf)
  if src == "" then
    return
  end
  local pdf = vim.fn.fnamemodify(src, ":r") .. ".pdf"
  vim.system({ "pandoc", src, "-o", pdf, "--pdf-engine=typst" }, { text = true }, function(res)
    vim.schedule(function()
      if res.code ~= 0 then
        vim.notify(res.stderr, vim.log.levels.ERROR, { title = "pandoc" })
      elseif on_done then
        on_done(pdf)
      end
    end)
  end)
end

vim.api.nvim_create_user_command("MdPdfToggle", function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].md_pdf then
    vim.b[buf].md_pdf = false
    vim.notify("Markdown PDF preview off")
    return
  end
  vim.b[buf].md_pdf = true
  md_pdf_render(buf, function(pdf)
    vim.system({ "sioyek", "--new-window", pdf }, { detach = true })
  end)
end, { desc = "Toggle markdown PDF auto-preview" })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = md_pdf,
  pattern = { "*.md", "*.markdown" },
  callback = function(ev)
    if vim.b[ev.buf].md_pdf then
      md_pdf_render(ev.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = md_pdf,
  pattern = "markdown",
  callback = function(ev)
    vim.keymap.set("n", "<leader>cP", "<cmd>MdPdfToggle<cr>", { buffer = ev.buf, desc = "Markdown PDF Preview" })
  end,
})
