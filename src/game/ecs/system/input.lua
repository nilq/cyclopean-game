s.input = {"input"}
s.input.update = function(i, input)
    input.left = love.keyboard.isDown("left")
    input.right = love.keyboard.isDown("right")
    input.up = not input.up and (love.keyboard.isDown("up") or love.keyboard.isDown("z"))
end
