--- @class Moveable: Node
Moveable = Node:extend()

-- Moveable is the super class for every object that can be moved on screen mostly by drag
function Moveable:init(X,Y,W,H)

    local args = (type(X) == 'table') and X or {T ={X or 0,Y or 0,W or 0,H or 0}}
    --Initialzing the super class
    Node.init(self, args)

    -- original functionnality, to check if the object position has to be updated, we check this state
    self.hasToMove = false

    -- visible transformation, can be different than the actual position,
    -- for exemple if object has to be drawn bigger, or to have smoother effects
    self.VT = {
        x = self.T.x,
        y = self.T.y,
        w = self.T.w,
        h = self.T.h,
        scale = self.T.scale
    }

    self.velocity = { x = 0, y = 0, scale = 0 }

    -- we add this object to the list of all moveable instances
    table.insert(G.MOVEABLES, self)

end

-- Draw function, basically just call the top class draw function
function Moveable:draw()
    Node.draw(self)
end

-- Move function, trigger all other function that need to be called when an object is being move, including moving it in space (moveXY)
-- NOTE : pour bouger les objets on peut utiliser un systeme de frame, a chaque update du jeu on va ajouter une frame puis pour chaque objet moveable recenser appliquer la fonction move sur chacun des objets
-- NOTE : pour bouger nos objets on va plutot trigger la fonction move aux moments voulus pour  le moment
function Moveable:move(dt)
    self:moveXY(dt)
end

-- Function used to move objects like cards in space
function Moveable:moveXY(dt)

    -- TODO : should try to move this variable to Game:update()
    local momentum = 10

    -- NOTE peut etre changer la velocity pour tester si ca marche,il faut quelle soit =/= de 0
    -- essayer de changer velocity ~= 0 a math.abs(self.velocity.x) > 0.01
    -- essayer aussi de changer le 30
    if (self.T.x ~= self.VT.x or self.velocity.x ~= 0) or
        (self.T.y ~= self.VT.y or self.velocity.y ~= 0)
    then
        self.velocity.x = momentum * self.velocity.x + (1-momentum)*(self.VT.x - self.T.x)*30*dt
        self.velocity.y = momentum * self.velocity.y + (1-momentum)*(self.VT.y - self.T.y)*30*dt
        self.T.x = self.T.x + self.velocity.x
        self.T.y = self.T.y + self.velocity.y
    end

end

--TODO REMOVE FUNCTION