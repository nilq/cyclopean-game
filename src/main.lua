bg_gray  = 0.95
bg_accum = 0

e, c, s = unpack(require "libs/ecs")

function love.load()
    c.position = {x = 0, y = 0}
    c.size = {w = 0, h = 0}
    c.color = {0, 0, 0}
    c.input = {}
    c.physics = {
        dx = 0,
        dy = 0,
        frc_x = 0.5,
        frc_y = 0.3,
        speed = 10
    }

    e.player = {"position", "size", "color", "physics", "input"}

    s.player = {"position", "size", "physics", "input"}
    s.player.update = function(i, position, size, physics)
        if love.keyboard.isDown("left") then
            physics.dx = physics.dx - physics.speed * dt
        end

        if love.keyboard.isDown("right") then
            physics.dx = physics.dx + physics.speed * dt
        end
    end

    s.block = {"position", "size", "color"}
    s.block.draw = function(i, position, size, color)
        -- sprite later
        love.graphics.setColor(color)
        love.graphics.rectangle("fill", position.x, position.y, size.w, size.h)
    end

    s.physics = {"position", "size", "physics"}
    s.physics.update = function(i, position, size, physics)
    end

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
end

function love.update(dt)
    bg_accum = bg_accum + dt * 10
    bg_gray = math.sin(bg_accum)
    love.graphics.setBackgroundColor(bg_gray, bg_gray, bg_gray)
end

function love.draw()
    s(s.block)
end
