bg_gray = 0.95
bg_accum = 0

e, c, s = unpack(require "libs/ecs")
require "game/ecs/components"

require "game/ecs/entity/block"
require "game/ecs/entity/blot"
require "game/ecs/entity/player"

require "game/ecs/system/block"
require "game/ecs/system/blot"
require "game/ecs/system/physics"
require "game/ecs/system/input"

debugSystems = require "game/ecs/system/debug"

game = require "game"

bump = require "libs/bump"

function math.lerp(a, b, t)
    return a + (b - a) * t
end

function math.cerp(a, b, t)
    local f = (1 - math.cos(t * math.pi)) * 0.5
    return a * (1 - f) + b * f
end

local state = game

function love.load()
    world = bump.newWorld()

    state:load()
end

function love.update(dt)
    state:update(dt)
end

function love.draw()
    state:draw()
    s(unpack(debugSystems))
end

function love.keypressed(key)
    if key == "r" then
        love.load()
    end
    s.input()
end

function love.keyreleased()
    s.input()
end
