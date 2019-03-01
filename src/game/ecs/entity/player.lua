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
