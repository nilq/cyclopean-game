local path  = "src/game/"

local level  = require(path .. "level")
local camera = require(path .. "camera")
local game   = {
    dt = 0,
}

function game:load()
    for i = 1, #e do
        e.delete(i)
    end

    level:load("res/levels/0.png")

    self.camera = camera(200, 500, 3, 3, 0)
end

function game:update(dt)
    self.dt = dt
end

function game:draw()
    self.camera:set()

    s(s.block, s.player)

    self.camera:unset()
end

return game