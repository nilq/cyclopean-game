s.blot = {"position", "radius", "color"}
s.blot.draw = function(i, position, size, color)
    -- sprite later
    love.graphics.setColor(color)
    love.graphics.circle("fill", position.x, position.y, radius.r)
end