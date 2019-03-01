local level = {
    size = 20,

    registry = {
        block  = { 0, 0, 0 },
        player = { 1, 1, 0 },
    },

    map = {},
}

function level:load(path)
    local image = love.image.newImageData(path)
    local map   = {}

    for x = 1, image:getWidth() do
        map[x] = {}

        for y = 1, image:getHeight() do
            rx, ry = x - 1, y - 1

            r, g, b = image:getPixel(rx, ry)

            for k, v in pairs(self.registry) do
                if r == v[1] and g == v[2] and b == v[3] then
                    self:spawn(k, self.size * rx, self.size * ry)
                end
            end
        end
    end
end

function level:spawn(k, x, y)
    if k == "block" then
        local conf = {
            position = { x = x,  y = y,  },
            size     = { w = 20, h = 20, },

            color    = { 255, 0, 0}
        }

        local id = e.block(conf)

        world:add(id, x, y, conf.size.w, conf.size.h)
    end

    if k == "player" then
        local conf = {
            position = {x = x, y = y},
            size  = {w = 10, h = 10},
            color = {255, 255, 0},
            input = {},
            physics = {
                dx = 0,
                dy = 0,
                frc_x = 0.5,
                frc_y = 0.3,
                speed = 10
            }
        }

        local id = e.player(conf)

        world:add(id, x, y, conf.size.w, conf.size.h)
    end
end

return level