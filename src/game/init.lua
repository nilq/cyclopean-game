local path  = "src/game/"

local level = require(path .. "level")
local game  = {}

function game:load()
    level:load("res/levels/0.png")
end

function game:update(dt)

end

function game:draw()

end

return game