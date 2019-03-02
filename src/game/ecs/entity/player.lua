e.player = {"position", "direction", "size", "sprite", "physics", "player", "input", "killable"}

s.player = {"position", "size", "physics", "input", "player", "killable"}
s.player.update = function(i, position, size, physics, input, player, killable)
    physics.grounded = false
    physics.wall_x = 0

    -- MOVEMENT:

    if input.left then
        physics.dx = physics.dx - physics.speed * game.dt
    end

    if input.right then
        physics.dx = physics.dx + physics.speed * game.dt
    end

    if input.respawn then
        killable.killed = true
    end

    if not physics.grounded then
        physics.dy = physics.dy + physics.gravity * game.dt
    end

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

        other = e.get(c.other)

        if (other.checkpoint) then
            killable.spawn_x = other.position.x
            killable.spawn_y = other.position.y - 25
        elseif (other.murderous) then
            killable.killed = true
        elseif (other.color) then
            other.color[1] = 255
            other.color[2] = 255
            other.color[3] = 0
        end
    end

    game.camera.x = math.cerp(game.camera.x, position.x, game.dt * 10)
    game.camera.y = math.cerp(game.camera.y, position.y, game.dt * 10)

    if input.up then
        if physics.grounded then
            physics.dy = -physics.jump_force
        elseif physics.wall_x ~= 0 then
            physics.dy = -physics.jump_force
            physics.dx = physics.wall_x * physics.speed / 2
        end
    end

    physics.dx = math.cerp(physics.dx, 0, physics.frc_x * game.dt)
    
    if killable.killed then
    physics.dy = 0
    physics.dx = 0
    position.x, position.y =
        world:move(
        i,
        killable.spawn_x,
        killable.spawn_y,
        function()
        end
    )
    killable.killed = false
end
end
