res = {
    sprite = {
        player = love.graphics.newImage("res/sprites/player.png"),
        gold = love.graphics.newImage("res/sprites/coin.png")
    },
    sound = {
        jump = {
            i = 1,
            res = {
                love.audio.newSource("res/sound/woosh_1.wav", "static"),
                love.audio.newSource("res/sound/woosh_2.wav", "static"),
                love.audio.newSource("res/sound/woosh_3.wav", "static"),
                love.audio.newSource("res/sound/woosh_4.wav", "static"),
            },
            play = function(self)
                love.audio.play(self.res[self.i])
                self.i = (self.i % 4) + 1
            end
        },
        ambience = {
            res = love.audio.newSource("res/sound/ambience.wav", "stream"),
            play = function(self)
                self.res:setVolume(0.1)
                self.res:setLooping(true)
                love.audio.play(self.res)
            end
        },
        death = {
            res = love.audio.newSource("res/sound/plop.wav", "static"),
            play = function(self)
                self.res:setVolume(0.5)
                love.audio.play(self.res)
            end
        },
        laugh = {
            res = love.audio.newSource("res/sound/laugh.wav", "static"),
            play = function(self)
                self.res:setVolume(0.5)
                love.audio.play(self.res)
            end
        }
    }
}
