local level = require "game/level"
local camera = require "game/camera"
local game = {
    dt = 0
}

function game:load()
    for i = 1, #e do
        e.delete(i)
    end

    level:load("res/levels/0.png")
    res.sound.ambience:play()

    love.window.setMode(200, 500, {fullscreen=true, msaa=0})

    self.camera = camera(800, 400, 1, 1, 0)

    self.background_hue = 0
    self.background_delta = -1
end

function game:update(dt)
    self.dt = dt

    s(s.sound, s.player,  s.inputReset)
end

function game:draw()
    love.graphics.setBackgroundColor(0, 0, 0)

    self.camera:set()

    love.graphics.setShader(effect)

    s(s.block, s.sprite, s.debug)

    self.camera:unset()
end

return game
