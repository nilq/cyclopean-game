s.input = {"input", "direction"}
s.input.update = function(i, input, direction)
    input.left = love.keyboard.isDown("left")
    input.right = love.keyboard.isDown("right")
    input.up = not input.up and (love.keyboard.isDown("up") or love.keyboard.isDown("z"))
    input.respawn = love.keyboard.isDown("backspace")
    direction[1] = (input.left and 1 or input.right and -1 or direction[1])
end

s.inputReset = {"input"}
s.inputReset.update = function(i, input)
    input.up = false
end
