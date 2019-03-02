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
        
        
        if(other.checkpoint)then
            print "checkpoint haha!"
        elseif (other.color) then
            other.color[1] = 255
            other.color[2] = 255
            other.color[3] = 0
        end
    end

    game.camera.x = math.cerp(game.camera.x, position.x, game.dt * 10)
    game.camera.y = math.cerp(game.camera.y, position.y, game.dt * 10)

    if not physics.grounded then
        physics.dy = physics.dy + physics.gravity * game.dt
    end

    if input.up then
        if physics.grounded then
            physics.dy = -physics.jump_force
        elseif physics.wall_x ~= 0 then
            physics.dy = -physics.jump_force * 2
            physics.dx = physics.wall_x * physics.speed * 1.5
        end
    end

    physics.dx = math.lerp(physics.dx, 0, physics.frc_x * game.dt)
    physics.dy = math.lerp(physics.dy, 0, physics.frc_y * game.dt)

    if killable.killed then
        position.x = killable.spawn_x
        position.y = killable.spawn_y
        killable.killed = false
    end
end
