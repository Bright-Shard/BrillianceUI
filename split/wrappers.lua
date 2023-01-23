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