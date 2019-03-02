s.debug = {"player"}
s.debug.update = function(i)
    love.graphics.setColor({0.3, 0, 1})
end

s.dplayer = {"player"}
s.dplayer.update = function(i)
    love.graphics.print(dump(e.get(i)), 0, 0)
end

s.dsize = {"size", "player"}
s.dsize.update = function(i, size)
    love.graphics.print("size: " .. dump(size), 0, 60)
end

s.dinput = {"input", "player"}
s.dinput.update = function(i, input)
    love.graphics.print("input: " .. dump(input), 0, 120)
end

s.dphysics = {"physics", "player"}
s.dphysics.update = function(i, physics)
    love.graphics.print("physics: " .. dump(physics), 0, 200)
end

return {s.debug, s.dplayer}
