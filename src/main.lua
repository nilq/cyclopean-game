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
    for i = 1, 10 do
        e.player {
            position = {x = love.math.random(1, 100), y = love.math.random(1, 100)},
            size = {w = 10, h = 10},
            color = {255, 0, 0},
            input = {},
            physics = {
                dx = 0,
                dy = 0,
                frc_x = 0.5,
                frc_y = 0.3,
                speed = 10
            }
        }
    end

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

    s(s.block)
end
