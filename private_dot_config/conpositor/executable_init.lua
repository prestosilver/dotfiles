-- want gaps plz
local gaps = require("lib.gaps")
local funcs = require("lib.funcs")
local mouse = require("lib.mouse")

-- add this first in case of crash
session:add_bind("AS", "Escape", funcs.quit())

-- some usefull consts
local force_debug = false
local terminal = "kitty"

-- load colorscheme and libraries
require("mondo.colors")

-- setup libraries
gaps.setup { inc = 4, toggle = true, value = 4, ratio = 2, outer = 20 }
mouse.setup {}

-- create my containers
stacks = { a = 1, b = 2, c = 3, d = 4, e = 5 }
tags = { session:new_tag("F1"), session:new_tag("F2"), session:new_tag("F3"), session:new_tag("F4") }

local function setup_abcd(root_container, ab_split, in_ac_split, in_bd_split, flip)
    local ac_split = in_ac_split
    local bd_split = in_bd_split
    if flip then
        ac_split = in_bd_split
        bd_split = in_ac_split
    end

    local bd_container = root_container:add_child(ab_split, 0.0, 1.0, 1.0)
    local ac_container = root_container:add_child(0.0, 0.0, ab_split, 1.0)

    local b_container = bd_container:add_child(0.0, 0.0, 1.0, bd_split)
    local d_container = bd_container:add_child(0.0, bd_split, 1.0, 1.0)

    local a_container = ac_container:add_child(0.0, 0.0, 1.0, ac_split)
    local c_container = ac_container:add_child(0.0, ac_split, 1.0, 1.0)
    if flip then
        a_container.stack = stacks.b
        b_container.stack = stacks.a

        c_container.stack = stacks.d
        d_container.stack = stacks.c
    else
        a_container.stack = stacks.a
        b_container.stack = stacks.b

        c_container.stack = stacks.c
        d_container.stack = stacks.d
    end
end

local default_layout = session:new_layout("] > [")
local center_layout = session:new_layout("] | [")
local lefty_layout = session:new_layout("] < [")
local default_layout_b = session:new_layout("[ > ]")
local center_layout_b = session:new_layout("[ | ]")
local lefty_layout_b = session:new_layout("[ < ]")

setup_abcd(default_layout.root, 0.7, 0.2, 0.4, false)
setup_abcd(center_layout.root, 0.5, 0.2, 0.4, false)
setup_abcd(lefty_layout.root, 0.3, 0.2, 0.4, false)

setup_abcd(lefty_layout_b.root, 0.7, 0.2, 0.4, true)
setup_abcd(center_layout_b.root, 0.5, 0.2, 0.4, true)
setup_abcd(default_layout_b.root, 0.3, 0.2, 0.4, true)

local lefty_cycle = {
    { lefty_layout,   center_layout,   default_layout, },  -- normal
    { lefty_layout_b, center_layout_b, default_layout_b, } -- flip
}

local flip_cycle = {
    { lefty_layout,   lefty_layout_b },  -- lefty
    { center_layout,  center_layout_b }, -- center
    { default_layout, default_layout_b } -- default
}

-- mouse functions
local mouse_client = nil
local mouse_client_position = {}
local mouse_floating = false
local mouse_resize = {}
mouse_resize.start = function(client, position)
    mouse_client = client
    mouse_client_position = client.position
end
mouse_resize.move = function(position)
    mouse_client_position.width = position.x - mouse_client_position.x
    mouse_client_position.height = position.y - mouse_client_position.y

    mouse_client.position = mouse_client_position
end

local mouse_move = {}
mouse_move.start = function(client, position)
    mouse_client = client
    mouse_floating = client.floating
    if mouse_floating then
        mouse_client_position = client.position
        mouse_client_position.x = mouse_client_position.x - position.x
        mouse_client_position.y = mouse_client_position.y - position.y
    end
end
mouse_move.move = function(position)
    if mouse_floating then
        local pos = {}
        pos.x = mouse_client_position.x + position.x
        pos.y = mouse_client_position.y + position.y
        pos.width = mouse_client_position.width
        pos.height = mouse_client_position.height

        mouse_client.position = pos
    else
        local monitor = session:active_monitor()
        local size = monitor.position
        mouse_client.monitor = monitor
        if position.y - size.y < 0.5 * size.height then
            if position.x - size.x < 0.5 * size.width then
                mouse_client.stack = stacks.a
            else
                mouse_client.stack = stacks.b
            end
        else
            if position.x - size.x < 0.5 * size.width then
                mouse_client.stack = stacks.c
            else
                mouse_client.stack = stacks.d
            end
        end
    end
end

local super = "L"
if force_debug or session.debug then
    super = "A"
end

-- mousebinds
mouse.addBind("resize", mouse_resize)
mouse.addBind("move", mouse_move)

session:add_mouse_bind(super, "Left", mouse.bind("move"))
session:add_mouse_bind(super, "Right", mouse.bind("resize"))

-- programs
session:add_bind(super, "Return", funcs.spawn(terminal, "--class=termA"))
session:add_bind(super .. "S", "Return", funcs.spawn(terminal, "--class=termB"))
session:add_bind(super .. "C", "Return", funcs.spawn(terminal, "--class=termB"))
session:add_bind(super, "I", funcs.spawn(terminal, "--class=htop", "-e", "htop"))
session:add_bind(super, "M", funcs.spawn(terminal, "--class=music", "-e", "kew"))
session:add_bind(super, "R", funcs.spawn(terminal, "--class=filesD", "-e", "ranger"))
session:add_bind(super .. "S", "R", funcs.spawn(terminal, "--class=filesB", "-e", "ranger"))
session:add_bind(super, "V", funcs.spawn(terminal, "--class=cava", "-e", "cava"))

session:add_bind(super .. "S", "S", funcs.spawn("ss.sh"))
session:add_bind(super, "W", funcs.spawn("vivaldi", "--ozone-platform=wayland"))
session:add_bind(super, "A", funcs.spawn("pavucontrol"))

-- launchers
session:add_bind(super, "D", funcs.spawn("bemenu-launcher"))
session:add_bind(super .. "S", "D", funcs.spawn("j4-dmenu-desktop", "--dmenu=menu"))
session:add_bind(super .. "S", "W", funcs.spawn("bwpcontrol", "menu"))
session:add_bind(super, "T", funcs.spawn("mondocontrol", "menu"))

-- misc session mgmt
session:add_bind(super, "H", funcs.cycle_layout(1, lefty_cycle))
session:add_bind(super .. "S", "H", funcs.cycle_layout(1, flip_cycle))
session:add_bind(super, "Tab", funcs.cycle_focus(1))
session:add_bind(super .. "S", "Tab", funcs.cycle_focus(-1))
session:add_bind(super, "Space", funcs.toggle_floating())
session:add_bind(super .. "S", "Escape", funcs.quit())
session:add_bind(super, "Q", funcs.kill_client())
session:add_bind(super, "F", funcs.toggle_fullscreen())

-- tags
for idx, tag in pairs(tags) do
    session:add_bind(super, "F" .. idx, funcs.set_monitor_tag(tag))
    session:add_bind(super .. "S", "F" .. idx, funcs.set_client_tag(tag))
end

-- stacks
for name, stack in pairs(stacks) do
    session:add_bind(super .. "S", "" .. stack, funcs.set_client_stack(stack))
end

-- debug tools

session:add_bind(super, "P", funcs.reload())
session:add_bind(super, "G", gaps.increase)
session:add_bind(super .. "S", "G", gaps.decrease)
session:add_bind(super .. "S", "V", gaps.toggle)

-- title modules
local icon_module = TextModule.new(function(client)
    return client.icon or ""
end)

local title_module = TextModule.new(function(client)
    return client.label or client.title or ""
end)

local debug_module = TextModule.new(function(client)
    local label = client.label or "(none)"
    local title = client.title or "(none)"
    local appid = client.appid or "(none)"
    return "[" .. label .. "] title: '" .. title .. "' appid: '" .. appid .. "'"
end)

local default_modules = {
    left = { icon_module },
    center = { title_module },
    right = {}
}

local debug_modules = {
    left = { icon_module },
    center = { debug_module },
    right = { title_module }
}

local popup_modules = {
    left = {},
    center = { title_module },
    right = {}
}

local function debug_window_set(value)
    if value then
        return function()
            local client = session:active_client()
            if client then
                client.modules = debug_modules
            end
        end
    else
        return function()
            local client = session:active_client()
            if client then
                client.modules = default_modules
            end
        end
    end
end

-- default modules
session:add_rule({}, function(client)
    client.modules = default_modules
end)

-- module switch bind
session:add_bind(super .. "S", "L", debug_window_set(false))
session:add_bind(super, "L", debug_window_set(true))

-- default rule
session:add_rule({}, function(client)
    client.stack = stacks.c
    client.floating = true
    client.border = 6
end)

local client_rule = function(filter, rule)
    local filter = filter
    local rule = rule
    session:add_rule(filter, function(client)
        if rule.stack ~= nil then
            client.stack = rule.stack
        else
            client.floating = true
        end
        if rule.icon ~= nil then
            client.icon = rule.icon
        end
        if rule.title ~= nil then
            client.label = rule.title
        end
        if rule.border ~= nil then
            client.border = rule.border
        end
        if rule.modules ~= nil then
            client.modules = rule.modules
        end
    end)
end

-- some client rules
client_rule({ appid = "termA" }, { stack = stacks.a, icon = "" })
client_rule({ appid = "termB" }, { stack = stacks.b, icon = "" })
client_rule({ appid = "termF" }, { icon = "" })
client_rule({ appid = "filesB" }, { stack = stacks.b, icon = "", title = "Files" })
client_rule({ appid = "filesD" }, { stack = stacks.d, icon = "", title = "Files" })
client_rule({ appid = "music" }, { stack = stacks.d, icon = "", title = "Music" })
client_rule({ appid = "discord" }, { stack = stacks.c, title = "Chat" })
client_rule({ appid = "htop" }, { stack = stacks.c, icon = "", title = "Tasks" })
client_rule({ appid = "Sxiv" }, { stack = stacks.b, icon = "", title = "Image" })
client_rule({ appid = "imv" }, { stack = stacks.b, icon = "", title = "Image" })
client_rule({ appid = "Chromium" }, { stack = stacks.c, icon = "" })
client_rule({ appid = "vivaldi-stable" }, { stack = stacks.c, icon = "" })
client_rule({ appid = "gimp" }, { stack = stacks.c, icon = "" })
client_rule({ appid = "pavucontrol" }, { stack = stacks.b, icon = "", title = "Volume" })
client_rule({ appid = "neovide" }, { stack = stacks.c, icon = "" })
client_rule({ appid = "PrestoEdit" }, { stack = stacks.c, icon = "" })
client_rule({ appid = "code-insiders" }, { stack = stacks.c, icon = "" })
client_rule({ appid = "dev.zed.Zed" }, { stack = stacks.c, icon = "" })
client_rule({ appid = "cava" }, { stack = stacks.b, icon = "", title = "Vis" })
client_rule({ appid = "SandEEE" }, { stack = stacks.c })
client_rule({ appid = "steam" }, { stack = stacks.c })

-- popups
client_rule({ title = "Discord Updater" }, { stack = nil, modules = popup_modules })
client_rule({ title = "GIMP Startup" }, { stack = nil, modules = popup_modules })

session:hook("startup", function(startup)
    session:spawn("wlr-randr", {
        "--output", "DP-3", "--mode", "2560x1080", "--left-of", "eDP-1",
        "--output", "eDP-1", "--right-of", "DP-3"
    })
    session:spawn("awww-daemon", {})
    session:spawn("dunst", {})
    session:spawn("waybar", {})
    session:spawn("blueman-applet", {})
    session:spawn("nm-applet", {})
    session:spawn("/usr/lib/gsd-xsettings", {})
end)

session:hook("add_monitor", function(monitor)
    monitor.layout = default_layout
end)

function reload_colors()
    package.loaded["mondo.colors"] = nil
    require("mondo.colors")
end

function get_memory()
    collectgarbage("collect")
    return string.format("%.0fb", 1000 * collectgarbage("count"))
end
