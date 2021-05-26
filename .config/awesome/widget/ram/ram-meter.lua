local wibox = require('wibox')
local watch = require('awful.widget.watch')
local dpi = require('beautiful').xresources.apply_dpi
local gears = require('gears')
local awful = require('awful')
local clickable_container = require('widget.material.clickable-container')

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/widget/ram/icons/'

local ram_widget =
wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
        image = PATH_TO_ICONS .. 'ram.svg',
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
        'bash -c "free | grep -z Mem.*Swap.*"',
        1,
        function(_, stdout)
            local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
            stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')
            local used_percent = used / total * 100
            local ramTxtColor = 'white'
            if (used_percent >= 90) then
                ramTxtColor = 'red'
            elseif (used_percent >= 80) then
                ramTxtColor = 'orange'
            end
            ram_widget.txt:set_markup(' <span foreground="' .. ramTxtColor .. '">' .. math.floor(used_percent) .. '%</span>')

            collectgarbage('collect')
        end
)

local ram_button = clickable_container(wibox.container.margin(ram_widget, dpi(10), dpi(10), 4, 4))
ram_button:buttons(
        gears.table.join(
                awful.button(
                        {},
                        1,
                        nil,
                        function()
                            awful.spawn('alacritty -e htop -s PERCENT_MEM')
                        end
                )
        )
)

return ram_button
