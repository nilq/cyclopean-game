e.player = {"position", "direction", "size", "sprite", "physics", "player", "input", "killable"}

s.player = {"position", "size", "physics", "input", "player", "killable"}
s.player.update = function(i, position, size, physics, input, player, killable)
    physics.grounded = false
    physics.wall_x = 0

    -- COLLISIONS --

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
        elseif (other.light) then
            love.graphics.setBackgroundColor(1, 1, 1)
        elseif (other.color) then
            other.color[1] = 0.15
            other.color[2] = 0.15
            other.color[3] = 0.15
        end
    end

    -- MOVEMENT --

    physics.dy = physics.dy + physics.gravity * game.dt

    if input.left and not input.right then
        if physics.grounded then
            physics.dx = math.lerp(physics.dx, -physics.speed, physics.frc_x * game.dt * 2)
        else
            physics.dx = physics.dx - physics.speed * game.dt
        end
    end

    if input.right and not input.left then
        if physics.grounded then
            physics.dx = math.lerp(physics.dx, physics.speed, physics.frc_x * game.dt * 2)
        else
            physics.dx = physics.dx + physics.speed * game.dt
        end
    end

    physics.dx = math.min(math.max(physics.dx, -physics.speed), physics.speed)

    if not (input.left and input.right) and physics.grounded then
        physics.dx = math.lerp(physics.dx, 0, physics.frc_x * game.dt)
    end

    if input.up then
        if physics.grounded then
            physics.dy = -physics.jump_force
        elseif physics.wall_x ~= 0 then
            physics.dy = -physics.jump_force
            physics.dx = physics.wall_x * physics.speed / 2
        end
    end

    -- DEATH --

    if input.respawn then
        killable.killed = true
    end

    if killable.killed then
	    physics.dy = 0
	    physics.dx = 0
	    position.x, position.y = world:move(
	        i,
	        killable.spawn_x,
	        killable.spawn_y,
	        function()
	        end
	    )
	    killable.killed = false
	end

    -- CAMERA --

    game.camera.x = math.cerp(game.camera.x, position.x, game.dt * 10)
    game.camera.y = math.cerp(game.camera.y, position.y, game.dt * 10)
end
