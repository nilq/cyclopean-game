local path = "src/game/"

local level = require(path .. "level")
local camera = require(path .. "camera")
local game = {
    dt = 0
}

function game:load()
    for i = 1, #e do
        e.delete(i)
    end

    level:load("res/levels/0.png")

    --love.window.setMode(200, 500, {fullscreen=true, msaa=0})

    self.camera = camera(200, 500, 1, 1, 0)
end

function game:update(dt)
    self.dt = dt

    s(s.player)
    s(s.inputReset)
end

function game:draw()
    self.camera:set()

    s(s.block, s.sprite, s.debug)
    
    love.graphics.setBackgroundColor(0, 0, 0)

    self.camera:unset()
end

return game
