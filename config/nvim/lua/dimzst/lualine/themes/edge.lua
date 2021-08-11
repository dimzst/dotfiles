-- =============================================================================
-- Genarated by lightline to lualine theme converter
--   https://gist.github.com/shadmansaleh/000871c9a608a012721c6acc6d7a19b9
-- License: MIT License
-- =============================================================================
local colors = {
  color1   = "#404455",
  color2   = "#333644",
  color3   = "#2b2d37",
  color4   = "#deb974",
  color5   = "#a0c980",
  color6   = "#ec7279",
  color7   = "#6cb6eb",
  color0   = "#c5cdd9",
}

local edge = {
  replace = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color0, bg = colors.color2 },
    a = { fg = colors.color3, bg = colors.color4 , gui = "bold", },
  },
  normal = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color0, bg = colors.color2 },
    a = { fg = colors.color3, bg = colors.color5 , gui = "bold", },
  },
  inactive = {
    b = { fg = colors.color0, bg = colors.color2 },
    c = { fg = colors.color0, bg = colors.color2 },
    a = { fg = colors.color0, bg = colors.color2 , gui = "bold", },
  },
  terminal = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color0, bg = colors.color2 },
    a = { fg = colors.color3, bg = colors.color5 , gui = "bold", },
  },
  visual = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color0, bg = colors.color2 },
    a = { fg = colors.color3, bg = colors.color6 , gui = "bold", },
  },
  insert = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color0, bg = colors.color2 },
    a = { fg = colors.color3, bg = colors.color7 , gui = "bold", },
  },
  command = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color0, bg = colors.color2 },
    a = { fg = colors.color3, bg = colors.color6 , gui = "bold", },
  },
}

return edge