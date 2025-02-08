---@class Game
Game = Object:extend()

function Game:init()

    G = self

    self:setGlobals()

end

-- might move this function to a respective file if too many global values
function Game:setGlobals()
    
    -- List of every moveables objects, instanciated in moveable:init     
    self.MOVEABLES = {}

    -- List of every object drawn on screen
    self.DRAW_HASH = {}

end