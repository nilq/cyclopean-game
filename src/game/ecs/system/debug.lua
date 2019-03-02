s.debug = {"player"}
s.debug.update = function(i)
    love.graphics.setColor({255, 255, 255})
end

s.dposition = {"position", "player"}
s.dposition.update = function(i, position)
    love.graphics.print("position: " .. dump(position), 0, 0)
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

return {s.debug, s.dposition, s.dsize, s.dinput, s.dphysics}
