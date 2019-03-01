bg_gray = 0.95

bg_accum = 0


e, c, s = require("libs/ecs")

function love.load()
    -- somethign
end

function love.update(dt)
    bg_accum = bg_accum + dt * 10
    bg_gray  = math.sin(bg_accum)

    love.graphics.setBackgroundColor(bg_gray, bg_gray, bg_gray)
end