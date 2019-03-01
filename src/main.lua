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


local state = game

function love.load()
    state:load()
end

function love.update(dt)
    state:update(dt)

    bg_accum = bg_accum + dt * 10
    bg_gray = math.sin(bg_accum)

    love.graphics.setBackgroundColor(bg_gray, bg_gray, bg_gray)
end

function love.draw()
    state:draw()
end
