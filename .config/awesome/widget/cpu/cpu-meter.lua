local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local mat_icon = require('widget.material.icon')
local icons = require('theme.icons')
local watch = require('awful.widget.watch')
local dpi = require('beautiful').xresources.apply_dpi
local gears = require('gears')
local awful = require('awful')
local clickable_container = require('widget.material.clickable-container')

local total_prev = 0
local idle_prev = 0

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/widget/cpu/icons/'

local cpu_widget =
wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
        image = PATH_TO_ICONS .. 'cpu.svg',
        resize = true,
    },
    {
        id = 'txt',
        widget = wibox.widget.textbox,
        forced_width = 30
    },
    layout = wibox.layout.fixed.horizontal
}

watch(
  [[bash -c "cat /proc/stat | grep '^cpu '"]],
  1,
  function(_, stdout)
    local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
      stdout:match('(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s')

    local total = user + nice + system + idle + iowait + irq + softirq + steal

    local diff_idle = idle - idle_prev
    local diff_total = total - total_prev
    local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

    local cpuTxtColor = 'white'
    if (diff_usage >= 90) then
       cpuTxtColor = 'red'
    elseif (diff_usage >= 80) then
       cpuTxtColor = 'orange'
    end
    cpu_widget.txt:set_markup(' <span foreground="' .. cpuTxtColor .. '">' .. math.floor(diff_usage) .. '%</span>')

    total_prev = total
    idle_prev = idle
    collectgarbage('collect')
  end
)

local cpu_button = clickable_container(wibox.container.margin(cpu_widget, dpi(8), dpi(8), 8, 8))
cpu_button:buttons(
        gears.table.join(
                awful.button(
                        {},
                        1,
                        nil,
                        function()
                            awful.spawn('mate-system-monitor')
                        end
                )
        )
)

return cpu_button
