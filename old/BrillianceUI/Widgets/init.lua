-- GLOBALS ----------------------------------------------------------
brilliance = nil
styles = nil
tweens = nil
bulkFade = nil
tweenService = game:GetService("TweenService")



-- WIDGETS LIST ----------------------------------------------------------
local widgets = {}
widgets.__call = function(_, brillianceInstance)
    brilliance = brillianceInstance
    styles = brilliance:getImport("Styles")
    tweens = brilliance:getImport("Tweens")
    bulkFade = brilliance:getImport("BulkFade")
    return widgets
end
setmetatable(widgets, widgets)



-- GENERIC WIDGET ----------------------------------------------------------
local widget = {
    -- Methods
    style = function(self, newStyle)
        if type(newStyle) == "string" then
            newStyle = styles:styleFromString(newStyle)
        end
        for property, value in pairs(newStyle or {}) do
            if property == "CornerRadius" then
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, value)
                corner.Parent = self.root
                continue
            end
            self.root[property] = value
        end
    
        return self
    end,
    setProp = function(self, prop, value)
        self.root[prop] = value
        
        return self
    end,
    setParent = function(self, parent)
        self.root.Parent = parent
        
        return self
    end,
    addChild = function(self, child, id)
        child:setParent(self.root)
        id = id or child.id
        self.children[id or "widget "..#self.children] = child
    
        return self
    end,
    addChildren = function(self, children)
        for id, child in pairs(children) do
            child:setParent(self.root)
            self.children[id] = child
        end
    
        return self
    end,

    getChild = function(self, id)
        return self.children[id]
    end,
    getChildren = function(self)
        return pairs(self.children)
    end,
    getY = function(self)
        return self.root.Position.Y.Offset
    end,
    getX = function(self)
        return self.root.Position.X.Offset
    end,
    getYSize = function(self)
        return self.root.Size.Y.Offset
    end,
    getXSize = function(self)
        return self.root.Size.X.Offset
    end,
    getProp = function(self, prop)
        return self.root[prop]
    end,

    removeChild = function(self, childID)
        self.children[childID] = nil
    end,
    Destroy = function(self)
        for _, child in ipairs(self.children) do
            child:Destroy()
        end
        self.root:Destroy()
    end
}

-- Metamethods
widget.__index = widget
widget.__len = function(self)
    return #self.children
end

-- Constructor
widget.__call = function(_, class)
    -- Make a new widget
    local self = setmetatable({}, widget)

    -- Properties
    self.root = Instance.new(class)
    self.children = {}
    self.id = nil

    -- Return data
    return self
end

setmetatable(widget, widget)



-- NOTIFICATION WIDGET ----------------------------------------------------------
local notificationSrc = {
    -- Methods
    setTitle = function(self, text)
        self:getChild("title"):setProp("Text", text)
        return self
    end,
    setText = function(self, text)
        self:getChild("text"):setProp("Text", text)
    end,
    dismiss = function(self)
        if self.stage == 3 then
            brilliance.notifications:removeChild(self.id)
            self.progressTween:Cancel()
            self.tween:Cancel()
            self.progress:Destroy()
            self:Destroy()
            brilliance:moveNotifications()
        else
            self.tween:Cancel()
            self.stage = 2
            self.buildTween()
        end
    end,
    buildTween = function(self)
        if self.stage == 0 then -- Build slide out tween
            self.tween = tweenService:Create(
                self.root,
                tweens.info(1 - self.progress.Value),
                {Position = UDim2.new(1, -(styles.notif.size.width + styles.notif.size.padding), 1, self.targetY)}
            )
        elseif self.stage == 1 then -- Build progress bar tween
            self.tween = tweenService:Create(
                self:getChild("progressBar").root,
                tweens.info(tweens.length.progressBar, "Linear"),
                {Size = UDim2.new(1, 0, 0, styles.notif.size.progBarHeight)}
            )
        elseif self.stage == 2 then -- Build slide out tween
            self.tween = tweenService:Create(
                self.root,
                tweens.info(1 - self.progress.Value),
                {Position = UDim2.new(1, 1, 1, self.targetY)}
            )
        end

        self.progressTween = tweenService:Create(
            self.progress,
            tweens.info(1),
            {Value = 1}
        )

        self.tween.Completed:Once(function(playbackState) self:updateTween(playbackState) end)
    end,
    updateTween = function(self, playbackState)
        -- Previous tween completed
        if playbackState == Enum.PlaybackState.Completed then
            self.progress.Value = 0
            self.stage += 1
            if self.stage < 3 then
                self:buildTween()
                self.progressTween:Play()
                self.tween:Play()
            elseif self.stage == 3 then
                self:dismiss()
            end

        -- Previous tween didn't complete
        else
            self:buildTween()
            self.tween:Play()
        end
    end
}

-- Metamethods
notificationSrc.__index = notificationSrc

-- Constructor
notificationSrc.__call = function(_, args)
    -- Make a new notification
    local self = widget("Frame"):style(styles.notif.frame)
    setmetatable(self, notificationSrc)
    
    -- Properties
    self.tween = nil
    self.progressTween = nil
    self.stage = 0
    self.targetY = 0
    self.id = #brilliance.notifications + 1
    self.progress = Instance.new("NumberValue")

    -- Notification widgets
    self:addChildren({
        progressBar = widget("Frame"):style(styles.notif.progressBar) -- The progress bar
                        :addChild(widget("Frame"):style(styles.notif.progressBarTop), "top"), -- To make the top corners of the progress bar flat, we add a new frame
        title = widget("TextLabel"):style(styles.notif.title), -- The title
        text = widget("TextLabel"):style(styles.notif.text) -- The bottom text/description/idrk
    })
    self:setTitle(args.title)
    self:setText(args.text)

    -- Reposition the notification
    local ypos = styles.notif.size.height * self.id
    ypos += styles.notif.size.padding * self.id
    self:setProp("Position", UDim2.new(1, 1, 1, -ypos))
    self.targetY = -ypos

    -- Build the tweens
    self:buildTween()

    -- Return data
    return self
end

setmetatable(notificationSrc, widget)
notif = setmetatable({}, notificationSrc)



-- BUTTON WIDGET ----------------------------------------------------------
local buttonSrc = {
    -- Methods
    press = function(self)
        self.callback(self)
    end,
    setCallback = function(self, newCallback)
        self.callback = newCallback
    end,
    setText = function(self, text)
        self:setProp("Text", text)
    end
}

--Metamethods
buttonSrc.__index = buttonSrc

-- Constructor
buttonSrc.__call = function(_, args)
    -- Instantiate a button
    local self = widget("TextButton"):style(styles.button)
    setmetatable(self, buttonSrc)

    -- Properties
    self.callback = function(self) print("Button "..self.id.." pressed") end
    self:setProp("Text", args.text)
    self:setProp("Size", UDim2.new(1, -(styles.widgetSize.padding * 2), 0, styles.widgetSize.height))

    -- Callback function & click animation
    self.root.MouseButton1Down:Connect(function()
        tweens.bg(self, styles.colour.colourAltLight, true)
        self.callback()
    end)
    self.root.MouseButton1Up:Connect(function()
        tweens.bg(self, styles.colour.bgDark, true)
    end)

    -- Return data
    return self
end

setmetatable(buttonSrc, widget)
button = setmetatable({}, buttonSrc)



-- LABEL WIDGET ----------------------------------------------------------
local labelSrc = {
    setText = function(self, text)
        self:setProp("Text", text)
    end
}

-- Metamethods
labelSrc.__index = labelSrc

-- Constructor
labelSrc.__call = function(_, args)
    -- Root label
    local self = widget("TextLabel"):style(styles.text)
    setmetatable(self, labelSrc)

    -- Label text
    self:setProp("Text", args.text)

    -- Calculate how much space the text will take up
    local maxSize = Vector2.new(
        (self:getXSize() - (styles.widgetSize.padding * 2)) - 2,
        1
    )
    local textSize = game:GetService("TextService"):GetTextSize(
        args.text,
        styles.text.TextSize,
        styles.text.Font,
        maxSize
    )

    -- Then set that as the label size
    self:setProp("Size", UDim2.new(1, -(styles.widgetSize.padding * 2), 0, textSize.Y))

    -- Return data
    return self
end

setmetatable(labelSrc, widget)
label = setmetatable({}, labelSrc)



-- WINDOW WIDGET ----------------------------------------------------------
local windowSrc = {
    -- Methods
    updateGroup = function(self)
        local group = self.children
        table.insert(group, self.root)
        self.group = bulkFade.CreateGroup(group)
        return self.group
    end,
    show = function(self)
        brilliance:disable() -- Prevent toggling app visibility
        self:updateGroup():FadeIn() -- Fade in the window
        wait(tweens.length.bulkFade) -- Wait for the transition to finish
        brilliance:enableWindow(self) -- Enable the window in Brilliance
        brilliance:enable() -- Allow toggling app visibility
    end,
    hide = function(self)
        brilliance:disable() -- Prevent toggling app visibility
        self:updateGroup():FadeOut() -- Fade out the window
        wait(tweens.length.bulkFade) -- Wait for the transition to finish
        brilliance:disableWindow(self) -- Disable the window in Brilliance
        brilliance:enable() -- Allow toggling app visibility
    end,
    addWidget = function(self, widget, id)
        id = #self.children.." "..id
        widget:setProp("Position", UDim2.new(0, styles.widgetSize.padding, 0, self.usedSpace))
        widget.id = id
        self:addChild(widget, id)
        self.usedSpace += (widget:getYSize() + styles.widgetSize.padding)
    end
}

-- Metamethods
windowSrc.__index = windowSrc

-- Constructor
windowSrc.__call = function(_, args)
    -- The root window
    local self = widget("Frame"):style(styles.window)
    setmetatable(self, windowSrc)

    -- Properties
    self.group = nil
    self.usedSpace = 0

    -- Title on the window
    local title = widget("TextLabel")
    title:style(styles.title)
    self:addChild(title, "Title")

    -- Set the title
    self.id = args.title
    self:setProp("Name", args.title)
    self:getChild("Title"):setProp("Text", args.title)

    -- Position/size the window
    self:setProp("Position", args.position or UDim2.new(0, 0))
    self:setProp("Size", args.size or UDim2.new(0, 200, 0, 400))

    -- Make room for the title on the window
    self.usedSpace = (styles.widgetSize.padding + styles.title.Size.Y.Offset)

    return self
end

setmetatable(windowSrc, widget)
window = setmetatable({}, windowSrc)


-- RETURN DATA ----------------------------------------------------------
widgets.widget = widget
widgets.notification = notif
widgets.window = window
widgets.button = button
widgets.label = label
return widgets