s.physics = {"position", "size", "physics", "input"}
s.physics.update = function(i, position, size, physics, input)
    if input.left then
        physics.dx = physics.dx - physics.speed * game.dt
    end

    if input.right then
        physics.dx = physics.dx + physics.speed * game.dt
    end
end
