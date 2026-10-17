-- Pandoc filter (Typst output only): \begin{cases} -> Typst cases(...).
-- pandoc's TeX->Typst math writer turns cases into a bare "{" plus line breaks,
-- so the brace doesn't stretch over the rows; rebuild it with cases() instead.

if FORMAT ~= "typst" then
  return {}
end

-- TeX snippet -> Typst math via pandoc's own writer; nil if it can't be converted
local function to_typst(tex)
  if not tex:match("%S") then
    return ""
  end
  local doc = pandoc.Pandoc({ pandoc.Plain({ pandoc.Math("InlineMath", tex) }) })
  return pandoc.write(doc, "typst", { wrap_text = "none" }):match("^%$(.-)%$%s*$")
end

-- escape commas that would otherwise split cases() arguments (outside groups and strings)
local function escape_commas(s)
  local out, depth, in_str, i = {}, 0, false, 1
  while i <= #s do
    local c = s:sub(i, i)
    if c == "\\" then
      c = s:sub(i, i + 1)
      i = i + 1
    elseif c == '"' then
      in_str = not in_str
    elseif not in_str then
      if c:match("[%(%[{]") then
        depth = depth + 1
      elseif c:match("[%)%]}]") then
        depth = depth - 1
      elseif c == "," and depth == 0 then
        c = "\\,"
      end
    end
    table.insert(out, c)
    i = i + 1
  end
  return table.concat(out)
end

local function split(s, sep)
  local parts, start = {}, 1
  while true do
    local i, j = s:find(sep, start, true)
    if not i then
      table.insert(parts, s:sub(start))
      return parts
    end
    table.insert(parts, s:sub(start, i - 1))
    start = j + 1
  end
end

function Math(el)
  local pre, body, post = el.text:match("^(.-)\\begin{cases}(.-)\\end{cases}(.*)$")
  if not body then
    return nil
  end
  local rows = {}
  for _, row in ipairs(split(body, "\\\\")) do
    if row:match("%S") then
      local cells = {}
      for _, cell in ipairs(split(row, "&")) do
        local typ = to_typst(cell)
        if not typ then
          return nil
        end
        table.insert(cells, escape_commas(typ))
      end
      table.insert(rows, table.concat(cells, " & "))
    end
  end
  pre, post = to_typst(pre), to_typst(post)
  if not pre or not post then
    return nil
  end
  -- trimmed: in Typst, spaces just inside the $ delimiters make the math display-style
  local typ = ("%s cases(%s) %s"):format(pre, table.concat(rows, ", "), post):match("^%s*(.-)%s*$")
  if el.mathtype == "DisplayMath" then
    return pandoc.RawInline("typst", "$ " .. typ .. " $")
  end
  return pandoc.RawInline("typst", "$" .. typ .. "$")
end
