local awful = require('awful')
local icons = require('theme.icons')
local apps = require('configuration.apps')

local tags = {
  {
    icon = icons.firefox,
    type = 'firefox',
    defaultApp = apps.default.browser,
    screen = 1
  },
  {
    icon = icons.code,
    type = 'code',
    defaultApp = apps.default.editor,
    screen = 1
  },
  {
    icon = icons.social,
    type = 'social',
    defaultApp = apps.default.social,
    screen = 1
  },
  {
    icon = icons.folder,
    type = 'files',
    defaultApp = apps.default.files,
    screen = 1
  },
  {
    icon = icons.study,
    type = 'any',
    defaultApp = apps.default.study,
    screen = 1
  }
}

awful.layout.layouts = {
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.right,
  awful.layout.suit.max,
}

local screen_layouts = {
    [1] = awful.layout.suit.tile.right,
    [2] = awful.layout.suit.tile.left
}

awful.screen.connect_for_each_screen(
  function(s)
    for i, tag in pairs(tags) do
      awful.tag.add(
        i,
        {
          icon = tag.icon,
          icon_only = true,
          layout = screen_layouts[s.index],
          gap_single_client = false,
          gap = 8,
          screen = s,
          defaultApp = tag.defaultApp,
          selected = i == 1
        }
      )
    end
  end
)

_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = 8
    end
  end
)
