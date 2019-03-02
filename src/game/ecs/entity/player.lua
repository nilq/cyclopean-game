e.player = {"position", "size", "color", "physics", "input"}

s.player = {"position", "size", "physics", "input"}
s.player.update = function(i, position, size, physics)
    physics.grounded = false
    physics.wall_x   = 0

    -- INPUT:

    if love.keyboard.isDown("left") then
        physics.dx = physics.dx - physics.speed * game.dt
    end

    if love.keyboard.isDown("right") then
        physics.dx = physics.dx + physics.speed * game.dt
    end

    -- MOVEMENT:

    position.x, position.y, collisions = world:move(i, position.x + physics.dx, position.y + physics.dy)

    for i, c in ipairs(collisions) do
        if c.normal.y ~= 0 then

            if c.normal.y == -1 then
                physics.grounded = true
            end

            physics.dy = 0
        end

        if c.normal.x ~= 0 then
            physics.wall_x = c.normal.x

            physics.dx = 0
        end
    end


    game.camera.x = math.cerp(game.camera.x, position.x, game.dt * 10)
    game.camera.y = math.cerp(game.camera.y, position.y, game.dt * 10)

    if not physics.grounded then
        physics.dy = physics.dy + physics.gravity * game.dt
    end

    if love.keyboard.isDown("z") then
        if physics.grounded then
            physics.dy = -physics.jump_force
        elseif physics.wall_x ~= 0 then
            physics.dy = -physics.jump_force
            physics.dx = physics.wall_x * physics.jump_force * 1.5
        end
    end

    physics.dx = math.lerp(physics.dx, 0, physics.frc_x * game.dt)
    physics.dy = math.lerp(physics.dy, 0, physics.frc_y * game.dt)
end
