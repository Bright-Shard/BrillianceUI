# Making the App - Roblox
```lua
-- IMPORTS
-- Services
local rStore = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local plr = players.LocalPlayer

-- Require the modulescript
local brilliance = require(rStore.BrillianceUI)



-- GENERATE THE APP
local app = brilliance.init({
    -- Where the app should render (In this case the player's PlayerGui)
    -- Note that on Lua injectors, this defaults to gethui()
    parent = plr.PlayerGui,
    -- The app name
    title = "BrillianceUI Example",
    -- The keybind to show/hide the app (Uses Enum.KeyCode) (Optional, defaults to F3)
    keybind = Enum.KeyCode.F4,
})



-- WINDOWS
local window = app.window({
    -- The title that appears at the top of the window
    title = "Window 1",
    -- If the window should be draggable (True by default)
    draggable = true,
    -- Size of the window
    size = UDim2.new(0, 200, 0, 200),
    -- Position of the window
    position = UDim2.new(0, 50, 0, 50)
})

-- Same as above, with a new position
local second_window = app.window({
    -- The title that appears at the top of the window
    title = "Window 1",
    -- If the window should be draggable (True by default)
    draggable = true,
    -- Size of the window
    size = UDim2.new(0, 200, 0, 200),
    -- Position of the window
    position = UDim2.new(0, 50, 0, 300)
})



-- WIDGETS
-- BrillianceUI handles widget sizing/positioning for you!

-- Button widget
window.button({
    -- Button text
    text = "Toggle Window 2",
    -- Code that is run when the button is pressed
    callback = function()
        -- Show the window if it's hidden, and hide it if it's shown
        second_window.toggle()
    end
})

-- Label widget
second_window.label({
    -- Text
    text = "This window can be toggled!"
})

-- Checkbox widget
window.checkbox({
    -- Text
    text = "Is BrillianceUI cool?",
    -- Whether it should start out checked or not (false by default)
    checked = true
})



-- SHOW THE APP
-- It's called enable() because this allows the app to be toggled,
-- but doesn't actually show the app until the keybind is pressed.
app.enable()



-- NOTIFICATIONS
app.notify({
    -- Notification title
    title = "App loaded!",
    -- Notification description/text (Use \n for newlines)
    text = "Enjoy :D\nHit F3 to open"
})
```

# Making the app - Lua injector
