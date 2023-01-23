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