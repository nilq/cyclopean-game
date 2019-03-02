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

    self.camera = camera(200, 500, 3, 3, 0)

    level:spawn("blot", 0, 0)
end

function game:update(dt)
    self.dt = dt

    bg_accum = bg_accum + dt * 0.5
    bg_gray =
        1 * (1 - ((1 - math.cos(bg_accum * math.pi)) * 0.5)) +
        0.5 * (1 - math.cos(bg_accum))

    love.graphics.setBackgroundColor(bg_gray, 0, 0)
    s(s.player)
end

function game:draw()
    self.camera:set()

    s(s.block, s.debug)

    self.camera:unset()
end

return game
