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
            size     = {w = 10, h = 10},
            color    = {255, 255, 0},
            input    = {},
            physics  = {
                dx         = 0,    -- delta x, fancy term for velocity
                dy         = 0,
                frc_x      = 5,    -- delta x linearly interpolates towards 0 at `delta time * frc_x`
                frc_y      = 3,
                speed      = 10,   -- horizontal acceleration
                grounded   = false,-- standing on the ground?
                gravity    = 35,   -- when not grounded, dy is set to gravity
                jump_force = 8,    -- when jumping and grounded, dy is set to -jump_force
                wall_x     = 0,    -- what side the player is touching a wall: -1 left, 0 none, 1 right
            }
        }

        local id = e.player(conf)

        world:add(id, x, y, conf.size.w, conf.size.h)
    end

    if k == "blot" then
        local conf = {
            position = { x = x,  y = y,  },
            radius     = { r = 400 },

            color    = { 0, 0, 0}
        }

        local id = e.blot(conf)
    end
end

return level