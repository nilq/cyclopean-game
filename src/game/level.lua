local level = {
    size = 20,
    registry = {
        block = {0, 0, 0},
        checkpoint = {0, 1, 0},
        murderblock = {1, 0, 0},
        player = {1, 1, 0}
    },
    map = {}
}

function level:load(path)
    local image = love.image.newImageData(path)
    local map = {}

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
            position = {x = x, y = y},
            size = {w = 20, h = 20},
            color = {0, 0, 0}
        }

        local id = e.block(conf)

        world:add(id, x, y, conf.size.w, conf.size.h)
    end

    if k == "player" then
        local conf = {
            position = {x = x, y = y},
            killable = {spawn_x = x, spawn_y = y, killed = false},
            size = {w = 14, h = 19},
            direction = {1},
            sprite = {
                image = SPRITE_REGISTRY.player
            },
            input = {
                left = false,
                right = false,
                up = false,
                respawn = false
            },
            physics = {
                dx = 0, -- delta x, fancy term for velocity
                dy = 0,
                frc_x = 5, -- delta x linearly interpolates towards 0 at `delta time * frc_x`
                frc_y = 3,
                speed = 6, -- horizontal acceleration
                grounded = false, -- standing on the ground?
                gravity = 9.8, -- when not grounded, dy is set to gravity
                jump_force = 6, -- when jumping and grounded, dy is set to -jump_force
                wall_x = 0 -- what side the player is touching a wall: -1 left, 0 none, 1 right
            },
            player = {}
        }

        local id = e.player(conf)

        world:add(id, x, y, conf.size.w, conf.size.h)
    end

    if k == "checkpoint" then
        local conf = {
            position = {x = x, y = y},
            size = {w = 20, h = 20},
            color = {0, 255, 0},
            checkpoint = {}
        }

        local id = e.checkpoint(conf)

        world:add(id, x, y, conf.size.w, conf.size.h)
    end
    
    if k == "murderblock" then
        local conf = {
            position = {x = x, y = y},
            size = {w = 20, h = 20},
            color = {255, 0, 0},
            murderous = {}
        }

        local id = e.murderblock(conf)

        world:add(id, x, y, conf.size.w, conf.size.h)
    end

end

return level
