local ComponentBase = {}

-- Metatable
local metatable = {}

-- Constructor
function metatable.__call(_, components)
    local self = {}

    -- Set variables
    self.instance = nil
    self.meta = {}
    self.styles = {}
    self.specialStyles = {}
    self.components = {}

    function self.specialStyles.CornerRadius(self, radius)
        local uicorner = Instance.new("UICorner", self.instance)
        uicorner.CornerRadius = radius
    end

    -- Set methods
    function self:draw()
        for property, value in ipairs(self.styles) do
            -- If this property is a special style or normal one
            local special = false

            -- Check if the property is a special one
            for specialStyle, handler in pairs(self.specialStyles) do
                -- If it is special, run the handler
                if specialStyle == property then
                    handler(self, value)
                    special = true
                end
            end

            -- If the property was special, skip it, otherwise assign it
            if special then
                continue
            else
                self.instance[property] = value
            end
        end
    end

    -- Construct components
    for _, component in ipairs(components) do
        for property, defaultValue in component do
            print(tostring(property))
            if string.find(tostring(property), "__") == nil then
                self[property] = defaultValue
            end
        end
        table.insert(self.components, getmetatable(component))
    end

    -- Set & protect the metatable
    setmetatable(self, self.meta)
    self.meta.__metatable = 0

    return self
end

-- Set & protect the metatable
metatable.__metatable = 0
setmetatable(ComponentBase, metatable)

return ComponentBase