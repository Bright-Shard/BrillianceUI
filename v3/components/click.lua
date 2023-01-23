-- Metatable
local metatable = {}
metatable.__index = metatable
metatable.__metatable = "click"

-- Constructor
function metatable.__call(_, callback)
    local self = {}

    -- Properties
    self.callback = callback

    -- Methods
    function self:Click()
        self.callback()
    end
    function self:OnClick(callback)
        self.callback = callback
    end

    return self
end

local ClickableComponent = setmetatable({}, metatable)
return ClickableComponent