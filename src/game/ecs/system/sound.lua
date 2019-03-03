s.sound = {"input", "physics"}
s.sound.update = function(i, input, physics)
    if input.up and (physics.grounded or physics.wall_x ~= 0) then
        res.sound.jump:play()
    end
end