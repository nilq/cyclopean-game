e.player = {"position", "size", "color", "physics", "input"}

s.player = {"position", "size", "physics", "input"}
s.player.update = function(i, position, size, physics)
    if love.keyboard.isDown("left") then
        physics.dx = physics.dx - physics.speed * game.dt
    end

    if love.keyboard.isDown("right") then
        physics.dx = physics.dx + physics.speed * game.dt
    end

    if love.keyboard.isDown("space") then
        physics.dy = physics.dy - physics.speed * game.dt
    end

    position.x, position.y, collisions = world:move(i, position.x + physics.dx, position.y + physics.dy)

    for i, c in ipairs(collisions) do
        if c.normal.y ~= 0 then
            physics.dy = 0
        end

        if c.normal.x ~= 0 then
            physics.dx = 0
        end
    end

    physics.dy = physics.dy + 10 * game.dt

    game.camera.x = position.x
    game.camera.y = position.y

    if physics.dy > 0 then
        physics.dy = physics.dy - 5 * game.dt
    end

    if physics.dx > 0 then
        physics.dy = physics.dy - 5 * game.dt
    end
end
