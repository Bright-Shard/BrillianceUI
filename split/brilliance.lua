-- BRILLIANCEUI ----------------------------------------------------------
local brilliance = {
    -- PROPERTIES
    gui = nil,
    visible = false,
    keybind = Enum.KeyCode.G,
    initialized = false,
    -- METHODS
    overrideStyle = function(self, new_style)
        if type(new_style) ~= "table" then
            error("overrideStyle requires the argument 'new_style' (a table of styles)")
        end

        for style_name, style_config in pairs(new_style) do
            styles[style_name] = style_config
        end
    end,
    window = function(self, args)  -- Needs args: title (string), size (udim2), position(udim2)
        -- Type checking
        if type(args) ~= "table" then
            args = {}
        end
        -- Catch nil values
        if args.title == nil or type(args.title) ~= "string" then
            args.title = "Window"
        end
        if args.size == nil or typeof(args.size) ~= "UDim2" then
            args.size = UDim2.new(0, styles.width.window, 0, styles.height.window)
        end
        if args.position == nil or typeof(args.position) ~= "UDim2" then
            args.position = UDim2.new(0, 50, 0, 50)
        end

        local window = widgets.window(args.title, args.size, args.position)  -- Make a new window

        self.gui:addChild("Window "..args.title, window)  -- Add it to the gui

        return wrappers.window(window)  -- Return a wrapper for the window
    end,
    show = function(self)
        tweens.show(self.gui)
        self.visible = true
    end,
    hide = function(self)
        tweens.hide(self.gui)
        self.visible = false
    end,
    toggle = function(self)
        if not self.initialized then return end

        if self.visible then
            self:hide()
        else
            self:show()
        end
    end,
    enable = function(self)
        self:hide()
        self.gui:setProp("Enabled", true)
        self.initialized = true
    end
}
-- METAMETHODS
brilliance.__index = brilliance
brilliance.__call = function(_, args)  --- Need args: parent (a parent for the gui), keybind (string)
    -- Type checks
    if type(args) ~= "table" then
        args = {}
    end
    -- Nil checks
    if args.parent == nil then
        if running_in_injector then
            parent = gethui()
        else
            parent = game:GetService("Players").LocalPlayer.PlayerGui
        end
    end
    
    local self = setmetatable({}, brilliance)

    self.gui = widgets.widget("ScreenGui"):setClass("root"):setParent(parent):setProp("ResetOnSpawn", false):setProp("Enabled", false)

    if args.keybind ~= nil then
        self.keybind = Enum.KeyCode[args.keybind]
    end

    uis.InputEnded:Connect(function(input, has_been_processed)
        if has_been_processed then return end

        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == self.keybind then
                self:toggle()
            end
        end
    end)

    return self  -- Return the wrapper
end
setmetatable(brilliance, brilliance)



-- Metatables? More like TABLES-AREN'T-FUCKING-CLASSES-GET-A-NEW-PROGRAMMING-LANGUAGE-WITH-ACTUAL-OOP-THAT-ISN'T-DOGSHIT-ALREADY-ROBLOX
return brilliance
