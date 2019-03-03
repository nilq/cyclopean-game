s.debug = {"player"}
s.debug.update = function(i)
    love.graphics.setColor({0.3, 0, 1})
end

s.dplayer = {"player"}
s.dplayer.update = function(i)
    love.graphics.print(dump(e.get(i)), 0, 0)
end

s.dfps = {"player"}
s.dfps.update = function(i)
    love.graphics.print("tps: "..game.dt, 10, 0)
end

return {s.debug, s.dplayer, s.dfps}
