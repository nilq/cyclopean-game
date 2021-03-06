e.player = {"position", "direction", "size", "sprite", "physics", "player", "input", "killable"}

s.player = {"position", "size", "physics", "input", "player", "killable"}
s.player.update = function(i, position, size, physics, input, player, killable)
    physics.grounded = false
    physics.wall_x = 0
    game.background_delta = -2
    game.background_red = game.background_red or 1

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
            game.background_delta = 1
        elseif (other.color) then
            other.color[1] = 0.15
            other.color[2] = 0.15
            other.color[3] = 0.15
        elseif other.gold and not game.ended then
            game.ended = true
            res.sound.laugh:play()
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
        res.sound.death:play()
        killable.killed = false
    end

    -- CAMERA --

    game.camera.x = math.cerp(game.camera.x, position.x, game.dt * 10)
    game.camera.y = math.cerp(game.camera.y, position.y, game.dt * 10)


    -- BACKGROUND --

    game.background_hue = math.max(0, math.min(1, game.background_hue + game.background_delta * game.dt))
    love.graphics.setBackgroundColor(game.background_hue, game.background_hue, game.background_hue)

    if game.ended then
        love.graphics.setBackgroundColor(game.background_red, 0, 0)
        for j=1, 50 do
            local k = love.math.random(1, e.len())
            local m = love.math.random(1, e.len())
            if m ~= i then
                local e = e.get(m)
                e.position.y = e.position.y + physics.gravity*love.math.random()*game.dt*1000
            end
            if k ~= i then
                e.delete(k)
            end
        end
        game.camera.sx = game.camera.sx - game.dt/80
        game.camera.sy = game.camera.sy - game.dt/80
        game.background_red = game.background_red - 0.001
        if game.background_red < 0 then
            os.exit()
        end
    end
end
