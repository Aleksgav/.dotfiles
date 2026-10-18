-- Typst -> PDF auto-preview: a `typst watch` job per buffer (rebuilds when the file or
-- its imports change on disk), viewed in sioyek, which reloads the PDF itself.
-- Live browser preview comes from typst-preview.nvim (<leader>cp, LazyVim typst extra).
local typst_pdf = vim.api.nvim_create_augroup("typst_pdf_preview", { clear = true })
local typst_pdf_watchers = {}

vim.api.nvim_create_user_command("TypstPdfToggle", function()
  local buf = vim.api.nvim_get_current_buf()
  if typst_pdf_watchers[buf] then
    typst_pdf_watchers[buf]:kill(15)
    typst_pdf_watchers[buf] = nil
    vim.notify("Typst PDF preview off")
    return
  end
  local src = vim.api.nvim_buf_get_name(buf)
  if src == "" then
    return
  end
  local pdf = vim.fn.fnamemodify(src, ":r") .. ".pdf"
  local job, opened, pending = nil, false, ""
  job = vim.system({ "typst", "watch", src, pdf, "--diagnostic-format", "short" }, {
    text = true,
    cwd = vim.fn.fnamemodify(src, ":h"),
    stdout = false,
    stderr = function(_, data)
      if not data then
        return
      end
      vim.schedule(function()
        -- typst writes a diagnostic (`file:line:col: error: message`) in pieces,
        -- so only complete lines are looked at
        pending = pending .. data
        local errors = {}
        for line in pending:gmatch("([^\n]*)\n") do
          if line:find("error: ", 1, true) then
            table.insert(errors, line)
          elseif
            not opened
            and (line:find("] compiled successfully", 1, true) or line:find("] compiled with warnings", 1, true))
          then
            opened = true
            vim.system({ "sioyek", "--new-window", pdf }, { detach = true })
          end
        end
        pending = pending:match("[^\n]*$")
        if #errors > 0 then
          vim.notify(table.concat(errors, "\n"), vim.log.levels.ERROR, { title = "typst" })
        end
      end)
    end,
  }, function()
    vim.schedule(function()
      -- died on its own: allow toggling it on again
      if typst_pdf_watchers[buf] == job then
        typst_pdf_watchers[buf] = nil
      end
    end)
  end)
  typst_pdf_watchers[buf] = job
end, { desc = "Toggle typst PDF auto-preview" })

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = typst_pdf,
  callback = function()
    for _, job in pairs(typst_pdf_watchers) do
      job:kill(15)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = typst_pdf,
  pattern = "typst",
  callback = function(ev)
    vim.keymap.set("n", "<leader>cO", "<cmd>TypstPdfToggle<cr>", { buffer = ev.buf, desc = "Typst PDF Preview" })
  end,
})
