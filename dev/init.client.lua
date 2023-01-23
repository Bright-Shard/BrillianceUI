local storage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local plr = players.LocalPlayer

local brilliance = require(storage.BrillianceUI)

function callback()
    print("hi")
end
function callback2()
    print("hi2")
end

local component = brilliance.ComponentBase({
    brilliance.Components.Click(callback)
})

component:Click()
component:OnClick(callback2)
component:Click()

--[[
plr.CharacterAdded:wait()

local app = brilliance()

local window = app:window()

window:button()

window:label()

app:enable()

window.checkbox({
	text = 'Checkbox :eyes:'
})

windowTwo.label({
	text = 'Pretty cool, right? :P'
})

app.enable()

app.notify({
	title = "BrillianceUI Loaded",
	text = "No errors\nkek"
})
wait(2)
app.notify({
    title = "2",
    text = "..."
})
wait(2)
app.notify({
    title = "3",
    text = "..."
})
]]--
