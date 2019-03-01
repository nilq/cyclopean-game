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

world   = bump.newWorld()

function math.lerp(a,b,t) return a+(b-a)*t end

local state = game

function love.load()
    state:load()
end

function love.update(dt)
    state:update(dt)

    bg_accum = bg_accum + dt * 10
    bg_gray = math.sin(bg_accum)

    love.graphics.setBackgroundColor(0, 0, bg_gray)
end

function love.draw()
    state:draw()
end
