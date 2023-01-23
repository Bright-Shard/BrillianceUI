-- Metatable
local metatable = {}
metatable.__index = metatable
metatable.__metatable = "parent"

-- Constructor
function metatable.__call(_)
    local self = {}

    -- Properties
    self.children = {}

    -- Methods
    function self:addChild(child)
        table.insert(self, child)
    end

    return self
end

local ParentComponent = setmetatable({}, metatable)
return ParentComponent