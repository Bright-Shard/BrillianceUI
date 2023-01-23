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
