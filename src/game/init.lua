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

    self.camera = camera(200, 500, 1, 1, 0)
end

function game:update(dt)
    self.dt = dt

    bg_accum = bg_accum + dt * 0.1
    bg_gray = 1 * (1 - ((1 - math.cos(bg_accum * math.pi)) * 0.5)) + 0.5 * (1 - math.cos(bg_accum))

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
