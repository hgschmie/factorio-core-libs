--- Functions for working with directions and orientations.
-- @module Area.Direction
-- @usage local Direction = require('stdlib.area/direction')
-- @see defines.direction

local Direction = {
    __class = 'Direction',
    __index = require('stdlib.core')
}
setmetatable(Direction, Direction)

--- defines.direction.north
Direction.north = defines.direction.north
--- defines.direction.east
Direction.east = defines.direction.east
--- defines.direction.west
Direction.west = defines.direction.west
--- defines.direction.south
Direction.south = defines.direction.south
--- defines.direction.northeast
Direction.northeast = defines.direction.northeast
--- defines.direction.northwest
Direction.northwest = defines.direction.northwest
--- defines.direction.southeast
Direction.southeast = defines.direction.southeast
--- defines.direction.southwest
Direction.southwest = defines.direction.southwest

-- 2.0 stuff

Direction.northnortheast = defines.direction.northnortheast
Direction.northnorthwest = defines.direction.northnorthwest
Direction.eastnortheast = defines.direction.eastnortheast
Direction.eastsoutheast = defines.direction.eastsoutheast
Direction.southsoutheast = defines.direction.southsoutheast
Direction.southsouthwest = defines.direction.southsouthwest
Direction.westnorthwest = defines.direction.westnorthwest
Direction.westsouthwest = defines.direction.westsouthwest

---@type table<integer, defines.direction>
local directions = {
    [0] = Direction.north,
    Direction.northnortheast,
    Direction.northeast,
    Direction.eastnortheast,
    Direction.east,
    Direction.eastsoutheast,
    Direction.southeast,
    Direction.southsoutheast,
    Direction.south,
    Direction.southsouthwest,
    Direction.southwest,
    Direction.westsouthwest,
    Direction.west,
    Direction.westnorthwest,
    Direction.northwest,
    Direction.northnorthwest
}

---@param direction number
---@return defines.direction direction
local function normalize(direction)
    return assert(directions[math.floor(direction % 16)])
end

--- Returns the opposite direction
---@param direction defines.direction the direction
---@return defines.direction direction the opposite direction
function Direction.opposite(direction)
    return normalize(direction + 8)
end

--- Returns the next direction.
--> For entities that only support two directions, see @{opposite}.
---@param direction defines.direction the starting direction
---@param eight_way? boolean true to get the next direction in 8-way (note: not many prototypes support 8-way)
---@return defines.direction direction the next direction
function Direction.next(direction, eight_way)
    return normalize(direction + (eight_way and 2 or 4))
end

--- Returns the previous direction.
--> For entities that only support two directions, see @{opposite}.
---@param direction defines.direction the starting direction
---@param eight_way? boolean true to get the previous direction in 8-way (note: not many prototypes support 8-way)
---@return defines.direction direction the next direction
function Direction.previous(direction, eight_way)
    return normalize(direction + (eight_way and -2 or -4))
end

--- Returns an orientation from a direction.
---@param direction defines.direction
---@return number
function Direction.to_orientation(direction)
    return direction / 16
end

--- Returns a vector from a direction.
---@param direction defines.direction
---@param distance? number
---@return MapPosition.struct vector
function Direction.to_vector(direction, distance)
    distance = distance or 1
    ---@type number
    local x = 0
    ---@type number
    local y = 0
    if direction == Direction.north then
        y = y - distance
    elseif direction == Direction.northeast then
        x, y = x + distance, y - distance
    elseif direction == Direction.east then
        x = x + distance
    elseif direction == Direction.southeast then
        x, y = x + distance, y + distance
    elseif direction == Direction.south then
        y = y + distance
    elseif direction == Direction.southwest then
        x, y = x - distance, y + distance
    elseif direction == Direction.west then
        x = x - distance
    elseif direction == Direction.northwest then
        x, y = x - distance, y - distance
    end
    return { x = x, y = y }
end

-- Deprecated
do
    local Orientation = require('stdlib.area.orientation')
    Direction.opposite_direction = Direction.opposite
    Direction.direction_to_orientation = Direction.to_orientation

    function Direction.orientation_to_4way(orientation)
        return Orientation.to_direction(orientation)
    end

    function Direction.orientation_to_8way(orientation)
        return Orientation.to_direction(orientation, true)
    end

    ---@param direction defines.direction
    ---@param reverse? boolean
    ---@param eight_way? boolean
    ---@return defines.direction direction
    function Direction.next_direction(direction, reverse, eight_way)
        return normalize(direction + (eight_way and ((reverse and -2) or 2) or ((reverse and -4) or 4)))
    end
end

return Direction
