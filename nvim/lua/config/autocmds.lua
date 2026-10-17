-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ```cetz code blocks -> figures (see nvim/pandoc/cetz.lua)
local pandoc_dir = vim.fn.stdpath("config") .. "/pandoc"
local cetz_filter = "--lua-filter=" .. pandoc_dir .. "/cetz.lua"
-- \begin{cases} -> Typst cases() (pandoc's Typst writer drops the big brace); PDF only
local cases_filter = "--lua-filter=" .. pandoc_dir .. "/typst-cases.lua"

-- Markdown -> PDF auto-preview (pandoc + typst, viewed in sioyek)
local md_pdf = vim.api.nvim_create_augroup("md_pdf_preview", { clear = true })

local function md_pdf_render(buf, on_done)
  local src = vim.api.nvim_buf_get_name(buf)
  if src == "" then
    return
  end
  local pdf = vim.fn.fnamemodify(src, ":r") .. ".pdf"
  local cmd = { "pandoc", src, "-o", pdf, "--pdf-engine=typst", cetz_filter, cases_filter }
  vim.system(cmd, { text = true }, function(res)
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

-- Markdown -> HTML auto-preview (pandoc, served on localhost; the page reloads itself)
local md_html = vim.api.nvim_create_augroup("md_html_preview", { clear = true })
local md_html_servers = {}

local function md_html_render(buf, on_done)
  local src = vim.api.nvim_buf_get_name(buf)
  if src == "" then
    return
  end
  local html = vim.fn.fnamemodify(src, ":r") .. ".html"
  local tmp = html .. ".tmp"
  vim.system({
    "pandoc",
    src,
    "-o",
    tmp,
    "-t",
    "html",
    "--standalone",
    "--embed-resources",
    "--math-method=mathml",
    "-M",
    "pagetitle=" .. vim.fn.fnamemodify(src, ":t:r"),
    "-H",
    pandoc_dir .. "/live-reload.html",
    cetz_filter,
  }, { text = true, cwd = vim.fn.fnamemodify(src, ":h") }, function(res)
    vim.schedule(function()
      if res.code ~= 0 then
        os.remove(tmp)
        vim.notify(res.stderr, vim.log.levels.ERROR, { title = "pandoc" })
        return
      end
      -- rename is atomic, so the browser never reloads a half-written file
      vim.uv.fs_rename(tmp, html)
      if on_done then
        on_done(html)
      end
    end)
  end)
end

vim.api.nvim_create_user_command("MdHtmlToggle", function()
  local buf = vim.api.nvim_get_current_buf()
  if md_html_servers[buf] then
    md_html_servers[buf]:kill(15)
    md_html_servers[buf] = nil
    vim.notify("Markdown HTML preview off")
    return
  end
  local src = vim.api.nvim_buf_get_name(buf)
  if src == "" then
    return
  end
  local tcp = vim.uv.new_tcp()
  tcp:bind("127.0.0.1", 0)
  local port = tcp:getsockname().port
  tcp:close()
  md_html_servers[buf] = vim.system({
    "python3",
    "-m",
    "http.server",
    "--bind",
    "127.0.0.1",
    "--directory",
    vim.fn.fnamemodify(src, ":h"),
    tostring(port),
  }, { stdout = false, stderr = false })
  md_html_render(buf, function(html)
    vim.ui.open(("http://127.0.0.1:%d/%s"):format(port, vim.uri_encode(vim.fn.fnamemodify(html, ":t"), "rfc3986")))
  end)
end, { desc = "Toggle markdown HTML auto-preview" })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = md_html,
  pattern = { "*.md", "*.markdown" },
  callback = function(ev)
    if md_html_servers[ev.buf] then
      md_html_render(ev.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = md_html,
  callback = function()
    for _, server in pairs(md_html_servers) do
      server:kill(15)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = md_html,
  pattern = "markdown",
  callback = function(ev)
    vim.keymap.set("n", "<leader>cH", "<cmd>MdHtmlToggle<cr>", { buffer = ev.buf, desc = "Markdown HTML Preview" })
  end,
})
