local wibox = require('wibox')
local watch = require('awful.widget.watch')
local dpi = require('beautiful').xresources.apply_dpi
local gears = require('gears')
local awful = require('awful')
local clickable_container = require('widget.material.clickable-container')

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/widget/microphone/icons/'

local microphone_widget =
wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
        image = PATH_TO_ICONS .. 'microphone-off.svg',
        resize = true,
    },
    layout = wibox.layout.fixed.horizontal
}

watch(
  [[bash -c "pactl list sources | grep -A 10 $(pactl info | grep 'Default Source' | cut -f3 -d' ') | grep 'Mute: no'"]],
  1,
  function(_, _, _, _, exitcode)

      if(exitcode == 0) then
          icon = 'microphone-on.svg'
      else
          icon = 'microphone-off.svg'
      end
      microphone_widget.icon.image = PATH_TO_ICONS .. icon

    collectgarbage('collect')
  end
)

local cpu_button = clickable_container(wibox.container.margin(microphone_widget, dpi(8), dpi(8), 8, 8))
cpu_button:buttons(
        gears.table.join(
                awful.button(
                        {},
                        1,
                        nil,
                        function()
                        end
                )
        )
)

return cpu_button
