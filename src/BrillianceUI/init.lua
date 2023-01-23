-- BrillianceUI by BrightShard
-- GLOBALS ----------------------------------------------------------
widgets = {}
styles = {}
tweens = {}
running_in_injector = identifyexecutor ~= nil
tween_service = game:GetService("TweenService")
uis = game:GetService("UserInputService")





-- STYLES ----------------------------------------------------------



-- Data
styles.height = {
    window = 300,
    window_title = 35,
    text = 25,
    widget = 30,
    widget_padding = 10,
    notification = 80,
    notification_progress_bar = 10
}
styles.width = {
    notification = 300,
    window = 300,
	widget_padding = 10
}
styles.padding = {
    widget = 10,
    notification = 25
}
styles.colours = {
    bg = Color3.fromHex("#303030"),
    bgDark = Color3.fromHex("#202020"),
    colour = Color3.fromHex("#EEEEEE"),
    colourAlt = Color3.fromHex("#4073FF"),
    colourAltLight = Color3.fromHex("#618BFF")
}
styles.tween_lengths = {
	show_hide = .1,
	progress_bar = 7,
	background = .2
}
styles.text_size = {
	window_title = 35,
	notification_title = 27,
	text = 20,
}
styles.font = Enum.Font.SourceSansSemibold
styles.font_bold = Enum.Font.SourceSansBold



-- Window styles
styles.window = {
	BackgroundColor3 = styles.colours.bg,
	BorderSizePixel = 0,
	Size = UDim2.new(0, styles.width.window, 0, styles.height.window),
	CornerRadius = 5,
}
styles.window_title = {
	Name = "Window Title",
	BackgroundColor3 = styles.colours.bg,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Size = UDim2.new(1, 0, 0, styles.height.window_title),
	Text = "",
	TextColor3 = styles.colours.colourAlt,
	TextSize = styles.text_size.window_title,
	Font = styles.font_bold
}



-- Widget styles
styles.button = {
	CornerRadius = 5,
	BackgroundColor3 = styles.colours.bgDark,
	BorderSizePixel = 0,
	Text = "",
	TextColor3 = styles.colours.colour,
	TextXAlignment = "Center",
	TextYAlignment = "Center",
	TextSize = styles.text_size.text,
	Font = styles.font,
	AutoButtonColor = false
}
styles.text = {
	BorderSizePixel = 0,
	BackgroundColor3 = styles.colours.bg,
	BackgroundTransparency = 1,
	Text = "",
	TextColor3 = styles.colours.colour,
	TextXAlignment = "Left",
	TextYAlignment = "Center",
	TextSize = styles.text_size.text,
	Font = Enum.Font.SourceSans
}
styles.text_bold = {
	BorderSizePixel = 0,
	BackgroundColor3 = styles.colours.bg,
	BackgroundTransparency = 1,
	Text = "",
	TextColor3 = styles.colours.colour,
	TextXAlignment = "Left",
	TextYAlignment = "Center",
	TextSize = styles.text_size.text,
	Font = styles.font
}



-- Notification styles
styles.notification = {
    Name = "Notification",
    BackgroundColor3 = styles.colours.bg,
	BorderSizePixel = 0,
	Size = UDim2.new(0, styles.width.notification, 0, styles.height.notification),
	ClipsDescendants = true,
	CornerRadius = 10
}
styles.notification_title = {
	Name = "Notification Title",
	BackgroundColor3 = styles.colours.bg,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 0, 10),
	Size = UDim2.new(1, 0, 0, 10),
	Text = "",
	TextColor3 = styles.colours.colourAlt,
	TextSize = styles.text_size.notification_title,
	Font = styles.font_bold
}
styles.notification_text = {
	Name = "Notification Text",
	BackgroundColor3 = styles.colours.bg,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 5, 0, 20),
	Size = UDim2.new(1, -(10 + styles.height.notification_progress_bar), 0, 40),
	Text = "",
	TextColor3 = styles.colours.colour,
	TextWrapped = true,
	TextXAlignment = "Left",
	TextYAlignment = "Top",
	TextSize = styles.text_size.text,
	Font = styles.font
}
styles.notification_progress_bar = {
	Name = "Notification Progress Bar",
	BackgroundColor3 = styles.colours.colourAlt,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 1, -(styles.height.notification_progress_bar)),
	Size = UDim2.new(0, 5, 0, styles.height.notification_progress_bar),
	ClipsDescendants = true,
	CornerRadius = 16
}
styles.notification_progress_bar_top = {
	Name = "Notification Progress Bar Top",
	BackgroundColor3 = styles.colours.colourAlt,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 0, 0),
	Size = UDim2.new(1, 0, 0, 4),
}





-- WIDGET TWEENS ----------------------------------------------------------
local tween_infos = {
    show = TweenInfo.new(
        styles.tween_lengths.show_hide,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.In
    ),
    hide = TweenInfo.new(
        styles.tween_lengths.show_hide,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    ),
    background = TweenInfo.new(
        styles.tween_lengths.background,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut
    )
}



-- TWEEN BACKGROUND COLOUR ------
tweens.background = function(target, colour)
    if type(target) ~= "table" or getmetatable(target) ~= "BrillianceUI Widget" then
        error("function tweens.background error: argument 'target' must be a Widget")
    end
    tween_service:Create(
        target.instance,
        tween_infos.background,
        {BackgroundColor3 = colour}
    ):Play()
end


-- TWEEN WIDGETS IN/OUT ------
local function build_tween_goals(target, constructor, class)
    -- Calculate the target transparency
    local target_transparency = constructor(target)
    -- The tween's goals
    local goals = {}

    -- If it has text, we need to make the text transparent, otherwise don't
    if class == "Label" or class == "Button" or class == "Title" then
        goals = {
            BackgroundTransparency = target_transparency,
            TextTransparency = target_transparency
        }
    else
        goals = {
            BackgroundTransparency = target_transparency
        }
    end

    -- Return the tween goals
    return goals
end

local function constructor_show(target)
    return styles[target:getProp("style")].BackgroundTransparency
end
local function constructor_hide(target)
    return 0
end

local function build_transparency_tweens(target, show_or_hide: string)
    -- Type checking
    if type(target) ~= "table" or getmetatable(target) ~= "BrillianceUI Widget" then
        error("function tweens.hide error: argument 'target' must be a Widget and argument 'tween_queue' must be a table")
    end

    -- Generate the constructor function
    local constructor = constructor_hide
    if show_or_hide == "show" then
        constructor = constructor_show
    end

    -- If the widget is disabled, don't queue it
    if target:getProp("disabled") then return end

    -- The queue of tweens to play
    local queue = {}
    -- Target widget's class
    local class = target:getClass()
    -- The Tween Info
    local tween_info = tween_infos[show_or_hide]

    -- If the widget isn't a root widget, add it to the queue
    if class ~= "root" then
        table.insert(
            queue,
            tween_service:Create(
                target.instance,
                tween_info,
                build_tween_goals(target, constructor, class)
            )
        )
    end

    -- If the widget has children, add those children to the queue
    if #target > 0 then
        for _, child in pairs(target.children) do
            table.insert(
                queue,
                tween_service:Create(
                    child.instance,
                    tween_info,
                    build_tween_goals(child, constructor, class)
                )
            )
        end
    end

    -- Return the tween queue
    return queue
end
tweens.show = function(target)
    for _, tween in ipairs(build_transparency_tweens(target, "show")) do
        tween:Play()
    end
end
tweens.hide = function(target)
    for _, tween in ipairs(build_transparency_tweens(target, "hide")) do
        tween:Play()
    end
end





-- BASE WIDGET CLASS ----------------------------------------------------------



-- Except it's a table, because Lua is the WORST FUCKING PROGRAMMING LANGUAGE IN EXISTENCE
widget = {
    -- PROPERTIES
    children = {},
    custom_props = {},
    instance = nil,
    class = "Widget",

    -- METHODS
    style = function(self, preset: string)
        for prop, val in pairs(styles[preset] or {}) do
            -- Custom "CornerRadius" style
            if prop == "CornerRadius" then
                local corner = Instance.new("UICorner")  -- Make a new UICorner
                corner.CornerRadius = UDim.new(0, val)  -- Set its radius to the CornerRadius value
                corner.Parent = self.instance  -- And parent it to this widget
                continue  -- Then skip to the next style property
            end

            -- Other properties
            self.instance[prop] = val
        end

        -- Store the style
        self:setProp("style", preset)

        return self  -- Return self (this allows function chains)
    end,
    addCustomProp = function(self, prop: string, value)
        self.custom_props[prop] = value  -- Add it to the custom_props list

        return self  -- Return self (this allows function chains)
    end,
    setClass = function(self, new_class: string)
        self.class = new_class
        return self
    end,
    getClass = function(self)
        return self.class
    end,
    setProp = function(self, prop: string, value)
        -- If the property is a custom property, set the custom property
        for name, _ in pairs(self.custom_props) do
            if name == prop then
                self.custom_props[prop] = value
                return self
            end
        end

        -- Otherwise set it as a normal Instance property
        self.instance[prop] = value  -- Set the property

        return self  -- Return self (this allows function chains)
    end,
    getProp = function(self, prop: string)
        -- Check each item in the custom_props
        for name, value in pairs(self.custom_props) do
            -- If it matches the prop we're looking for, return it
            if name == prop then
                return value
            end
        end

        -- If the value wasn't found in the custom_props,
        -- return the instance's value
        return self.instance[prop]
    end,
    setParent = function(self, new_parent)
        -- Root widgets don't need a Widget parent
        if self.class == "root" then
            self.instance.Parent = new_parent
            return self
        end

        -- Type checking
        if type(new_parent) ~= "table" or getmetatable(new_parent) ~= "BrillianceUI Widget" then
            error("widget:setParent() requires a Widget as a parent")
        end

        self.instance.Parent = new_parent.instance  -- Set the parent

        return self  -- Return self (this allows function chains)
    end,
    addChild = function(self, id: string, child)
        -- Type checking
        if type(child) ~= "table" or getmetatable(child) ~= "BrillianceUI Widget" then
            error("widget:addChild() requires a Widget as a child")
        end

        self.children[id] = child  -- Add the child to the children list
        child:setParent(self)  -- Set the child's parent

        return self  -- Return self (this allows function chains)
    end,
    getChild = function(self, id: string)
        return self.children[id]  -- Return the child
    end,
    getPosition = function(self)
        -- Return a list of the X and Y position offsets
        return {
            X = self.instance.Position.X.Offset,
            Y = self.instance.Position.Y.Offset
        }
    end,
    getSize = function(self)
        -- Return a list of the X and Y size offsets
        return {
            X = self.instance.Size.X.Offset,
            Y = self.instance.Size.Y.Offset
        }
    end,
    destroy = function(self)
        -- Remove references and hope Roblox garbage collects it :|
        -- Seriously Roblox has the shittiest way to clean up variables
        -- Fixing it would make games 1000000x faster lmao
        self.children = nil
        self = nil
    end
}

-- METAMETHODS
widget.__index = widget  -- For OOP
widget.__len = function(self)
    -- When something gets the length of a widget, return its number of children instead
    local counter = 0
    for name, _ in pairs(self.children) do
        counter += 1
    end
    return counter
end
-- Constructor
widget.__call = function(_, widget_class)
    local self = setmetatable({}, widget)  -- Make a new Widget instance

    -- Properties
    self.instance = Instance.new(widget_class)
    self.children = {}
    self.custom_props = {disabled = false, style = ""}

    return self  -- Return the new instance
end
-- Metatable
setmetatable(widget, widget)  -- Set the widget's metatable to itself
widget.__metatable = "BrillianceUI Widget"  -- Prevent future metatables from being set + a way to type check

widgets.widget = widget  -- Add it to the widgets list




-- WIDGET CLASSES ----------------------------------------------------------



-- WINDOW WIDGET ------
widgets.window = function(title: string, size, position)
    -- Type checks
    if typeof(size) ~= "UDim2" or typeof(position) ~= "UDim2" then
        error("window widget needs a title (string), size (table of {x, y}), and position (table of {x, y})")
    end

    local self = widget("Frame"):style("window"):setClass("Window")  -- Make a new Widget & style it

    -- Set the window title
    self:addChild("title", widget("TextLabel"):style("window_title"):setProp("Text", title):setClass("Title"))

    -- Size/Position the window
    self:setProp("Position", position)
    self:setProp("Size", size)

    return self  -- Return the window widget
end


-- NOTIFICATION WIDGET ------
widgets.notification = function(title: string, text: string)
    local self = widget("Frame"):style("notification"):setClass("Notification")  -- Make a new Widget instance & style it

    -- Add the title, text, and progress bar
    self:addChild(
        "Title",
        widget("TextLabel"):style("notification_title"):setProp("Text", title)
    )
    self:addChild(
        "Text",
        widget("Textlabel"):style("notification_text"):setProp("Text", text)
    )
    self:addChild(
        "Progress Bar",
        widget("Frame"):style("notification_progress_bar"):addChild("Top", widget("Frame"):style("notification_progress_bar_top"))
    )
    -- Calculate the notification's position

    return self  -- Return the notification
end


-- BUTTON WIDGET ------
widgets.button = function(text: string, callback)
    local self = widget("TextButton"):style("button"):setClass("Button")  -- Make a new Widget & style it

    -- Button callback
    self:addCustomProp("callback", callback)  -- Add a custom property tracking the callback
    self.instance.MouseButton1Down:Connect(function()
        self:getProp("callback")()  -- When the button is pressed, run the callback
    end)
    self:setProp("Text", text)  -- Set the button's text

    return self  -- Return the button
end


-- LABEL WIDGET ------
widgets.label = function(text: string)
    local self = widget("TextLabel"):style("text"):setClass("Label")  -- Make a new widget & style it
    self:setProp("Text", text)  -- Set the label's text

    return self  -- Return the label
end





-- BRILLIANCEUI WRAPPERS ----------------------------------------------------------
local wrappers = {}
local function position_widget(window, widget)
    -- Type checking
    if type(window) ~= "table" or type(widget) ~= "table" or getmetatable(window) ~= "BrillianceUI Widget" or getmetatable(widget) ~= "BrillianceUI Widget" then
        error("position_widget requires a window and widget, both of which must be Widgets")
    end

    local widget_count = #window - 1  -- The number of widgets already on the window
    local padding = widget_count * styles.height.widget_padding  -- The amount of padding widgets are taking up
    local height = widget_count * styles.height.widget  -- The amount of height the widgets themselves take up
    local header = styles.height.window_title  -- How much space the window's title takes up

    -- Add all of the above up, plus add more padding for the current widget
    local widget_pos_y = (padding + height + header + styles.height.widget_padding)
    local widget_pos_x = styles.width.widget_padding  -- The widgets are just placed inwards with padding by default

    return UDim2.new(0, widget_pos_x, 0, widget_pos_y)  -- Make  UDim & return it
end



-- BUTTON WRAPPER ------
wrappers.button = {
    -- PROPERTIES
    button = nil,
    -- METHODS
    press = function(self)
        self.button:getProp("callback")()
    end,
    setCallback = function(self, new_callback)
        self.button:setProp("callback", new_callback)
    end,
    setText = function(self, new_text: string)
        self.button:setProp("Text", new_text)
    end
}
-- METAMETHODS
wrappers.button.__index = wrappers.button
wrappers.button.__call = function(_, btn)
    -- Type checks
    if type(btn) ~= "table" or getmetatable(btn) ~= "BrillianceUI Widget" then
        error("window_wrapper requires the argument 'window' to be a Widget")
    end

    local self = setmetatable({}, wrappers.button)  -- Make a new instance
    self.button = btn  -- Set the button

    return self  -- Return the wrapper
end
setmetatable(wrappers.button, wrappers.button)



-- LABEL WRAPPER ------
wrappers.label = {
    -- PROPERTIES
    label = nil,
    -- METHODS
    setText = function(self, new_text: string)
        self.label:setProp("Text", new_text)
    end,
    setBold = function(self, bold: boolean)
        if bold then
            self.label:style("text_bold")
        else
            self.label:style("text")
        end
    end
}
-- METAMETHODS
wrappers.label.__index = wrappers.label
wrappers.label.__call = function(_, lbl)
    -- Type checks
    if type(lbl) ~= "table" or getmetatable(lbl) ~= "BrillianceUI Widget" then
        error("window_wrapper requires the argument 'window' to be a Widget")
    end

    local self = setmetatable({}, wrappers.label)
    self.label = lbl
    return self
end
setmetatable(wrappers.label, wrappers.label)



-- WINDOW WRAPPER ------
wrappers.window = {
    -- PROPERTIES
    window = nil,
    widget_width = 0,
    -- METHODS
    show = function(self)
        tweens.show(self.window)
        self.window:setProp("disabled", false)
    end,
    hide = function(self)
        tweens.hide(self.window)
        self.window:setProp("disabled", true)
    end,
    button = function(self, args)  -- Need args: text (string), callback (function)
        -- Type checking
        if type(args) ~= "table" then
            args = {}
        end
        -- Catch nils
        if args.text == nil or type(args.text) ~= "string" then
            args.text = "Button"
        end
        if args.callback == nil or typeof(args.callback) ~= "function" then
            args.callback = function()
                print("Button pressed")
            end
        end

        local btn = widgets.button(args.text, args.callback)  -- Make a new button

        btn:setProp("Position", position_widget(self.window, btn))  -- Position the button
        btn:setProp("Size", UDim2.new(0, self.widget_width, 0, styles.height.widget))  -- Size the button
        
        self.window:addChild("Button "..args.text, btn)  -- Add it to the window

        return wrappers.button(btn)  -- Return a wrapper for the button
    end,
    label = function(self, args)  -- Needs args: text (string)
        -- Type checking
        if type(args) ~= "table" then
            if type(args) == "string" then
                args = {text = args}
            else
                args = {}
            end
        end
        -- Catch nil values
        if args.text == nil or type(args.text) ~= "string" then
            args.text = "Label"
        end

        local lbl = widgets.label(args.text)  -- Make a new label

        lbl:setProp("Position", position_widget(self.window, lbl))  -- Position the label
        lbl:setProp("Size", UDim2.new(0, self.widget_width, 0, styles.height.widget))
        
        self.window:addChild("Label "..args.text, lbl)  -- Add the label to the window

        return wrappers.label(lbl)  -- Return a wrapper for the label
    end
}
-- METAMETHODS
wrappers.window.__index = wrappers.window
wrappers.window.__call = function(_, window)
    -- Type checks
    if type(window) ~= "table" or getmetatable(window) ~= "BrillianceUI Widget" then
        error("window_wrapper requires the argument 'window' to be a Widget")
    end

    local self = setmetatable({}, wrappers.window)  -- Make a new instance
    self.window = window  -- Set the window
    self.widget_width = (window:getSize().X - (styles.width.widget_padding * 2))

    return self  -- Return the new instance
end
setmetatable(wrappers.window, wrappers.window)




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





