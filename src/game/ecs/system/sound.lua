s.sound = {"input"}
s.sound.update = function(i, input)
    if input.up then
        res.sound.jump:play()
    end
end