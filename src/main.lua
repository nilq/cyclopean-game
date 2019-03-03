require "conf"

bg_gray = 0.95
bg_accum = 0

e, c, s = unpack(require "libs/ecs")
require "game/ecs/components"

require "game/ecs/entity/block"
require "game/ecs/entity/murderblock"
require "game/ecs/entity/lightblock"
require "game/ecs/entity/checkpoint"
require "game/ecs/entity/player"

require "game/ecs/system/block"
require "game/ecs/system/sprite"
require "game/ecs/system/input"
require "game/ecs/system/sound"


game = require "game"
bump = require "libs/bump"
require "res/resources"

function math.lerp(a, b, t)
    return a + (b - a) * t
end

function math.cerp(a, b, t)
    local f = (1 - math.cos(t * math.pi)) * 0.5
    return a * (1 - f) + b * f
end

function math.fuzzy_equals(a, b, tolerance)
    return a == b or math.abs(a-b) < tolerance
end

local state = game

function love.load()
    world = bump.newWorld()

    effect = love.graphics.newShader [[
        uniform bool  u_correct_ratio = false;
        uniform float u_radius        = 0.5;
        uniform float u_softness      = 0.45;
        uniform float u_opacity       = 1;

        vec4 effect(vec4 color, sampler2D texture, vec2 texCoords, vec2 screenCoords) {
            vec4 texColor = texture2D(texture, texCoords);
            vec2 position = (screenCoords.xy / love_ScreenSize.xy) - vec2(0.5);

            if (u_correct_ratio) {
                position.x *= love_ScreenSize.x / love_ScreenSize.y;
            }

            float vignette = smoothstep(
                u_radius,
                u_radius - u_softness,
                length(position)
            );

            texColor.rgb = mix(
                texColor.rgb,
                texColor.rgb * vignette,
                u_opacity
            );

            return texColor * color;
        }
    ]]

    love.graphics.setDefaultFilter("nearest", "nearest")
    state:load()
end

function love.update(dt)
    state:update(dt)
end

function love.draw()
    state:draw()
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
