local path  = "src/game/"

local level  = require(path .. "level")
local camera = require(path .. "camera")

local game   = {}

function game:load()
    level:load("res/levels/0.png")

    self.camera = camera(0, 0, 2, 2, 0)
end

function game:update(dt)
    self.camera:set()
    self.camera:unset()
end

function game:draw()

end

return game