s.sprite = {"position", "direction", "size", "sprite"}
s.sprite.draw = function(i, position, direction, size, sprite)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(
        sprite.image,
        position.x + size.w / 2,
        position.y,
        0,
        size.w / sprite.image:getWidth() * direction[1],
        size.h / sprite.image:getHeight(),
        sprite.image:getWidth() / 2
    )
end
