s.murderblock = {"position", "size", "color"}
s.murderblock.draw = function(i, position, size, color)
    -- sprite later
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", position.x, position.y, size.w, size.h)
end
