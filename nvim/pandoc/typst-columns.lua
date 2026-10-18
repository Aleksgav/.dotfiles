-- Pandoc filter (Typst output only): ::: columns / ::: column divs -> Typst grid.
-- pandoc's Typst writer drops the column layout (HTML gets it from the default
-- template's CSS). Percent widths become fr units so the gutter fits.

if FORMAT ~= "typst" then
  return {}
end

function Div(el)
  if not el.classes:includes("columns") then
    return nil
  end
  local cols, used, missing = {}, 0, 0
  for _, col in ipairs(el.content) do
    if col.t ~= "Div" or not col.classes:includes("column") then
      return nil -- only rewrite a clean columns > column structure
    end
    local w = col.attributes.width
    local pct = w and tonumber(w:match("^%s*([%d.]+)%%%s*$"))
    if pct then
      used = used + pct
    elseif not w then
      missing = missing + 1
    end
    table.insert(cols, { content = col.content, width = pct and (pct .. "fr") or w })
  end
  if #cols == 0 then
    return nil
  end
  -- columns without a width share what the percent widths leave over
  local share = math.max(100 - used, missing) / math.max(missing, 1)
  local widths = {}
  for _, col in ipairs(cols) do
    table.insert(widths, col.width or (("%g"):format(share) .. "fr"))
  end

  local grid = ("#grid(columns: (%s), column-gutter: 1.5em, align: horizon,"):format(table.concat(widths, ", "))
  local blocks = pandoc.Blocks({ pandoc.RawBlock("typst", grid) })
  for _, col in ipairs(cols) do
    blocks:insert(pandoc.RawBlock("typst", "["))
    blocks:extend(col.content)
    blocks:insert(pandoc.RawBlock("typst", "],"))
  end
  blocks:insert(pandoc.RawBlock("typst", ")"))
  return blocks
end
