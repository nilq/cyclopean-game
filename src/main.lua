bg_gray = 0.95
bg_accum = 0

e, c, s = unpack(require "libs/ecs")
require "game/ecs/components"

require "game/ecs/entity/block"
require "game/ecs/entity/player"

require "game/ecs/system/block"
require "game/ecs/system/physics"

game    = require "game"

bump    = require "libs/bump"

function math.lerp(a,b,t)
    return a + (b - a) * t
end

function math.cerp(a, b, t)
    local f = (1 - math.cos(t * math.pi)) * .5
    return a * (1 - f) + b * f
end

local state = game

function love.load()
    world = bump.newWorld()

    state:load()
end

function love.update(dt)
    state:update(dt)

    bg_accum = bg_accum + dt * 5
    bg_gray = 1 * (1 - ((1 - math.cos(bg_accum * math.pi)) * 0.5)) + 0.5 * ((1 - math.cos(bg_accum)))

    love.graphics.setBackgroundColor(0, 0, bg_gray)
end

function love.draw()
    state:draw()
end

function love.keypressed(key)
    if key == "r" then
        love.load()
    end
end