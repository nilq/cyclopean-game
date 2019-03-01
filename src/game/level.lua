local level = {}

function level:load(path, world_table)
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
    -- spawn
end

return level