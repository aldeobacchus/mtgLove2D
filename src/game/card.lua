local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()


--[[
    Pour recuperer l'objet sur lequel on focus :
    - recupérer la liste des objets avec laquelle le curseur est en collision
    - on loop parmi les differents objets en collision et on retourne le premier (celui le plus haut)
    - Lorsque l'on drag on ajout une variable dragging afin de pouvoir n'activer le hovering que si l'objet n'est pas en train d'etre drag

    Dans l'update on aura :
        --Reset all collision states, get every node that collides with the cursor, then update the focus and hover targets
        self:get_cursor_collision(G.CURSOR.T)
        self:set_cursor_hover()
        if self.L_cursor_queue then 
            self:L_cursor_press(self.L_cursor_queue.x, self.L_cursor_queue.y)
            self.L_cursor_queue = nil
        end

        Fonction utiles :
        set_cursor_hover() : defini l'objet actuellement en hover en recuperant le premier objet de la liste des objets en collision
        get_cursor_collision() : recupere la liste des objets en collision avec le curseur en regardant dans la liste des objet dessiné à lécran, quel objet est en collision avec l'emplacemnt du curseur
        collides_with_point(point) : determine si le node (objet) est en collision avec un point donné
            if _p.x >= T.x - _b and _p.y >= T.y - _b and _p.x <= T.x + T.w + _b and _p.y <= T.y + T.h + _b then 
                return true
            end
]]

--list of the different cards instanciated
Card = Moveable:extend()

function Card:init(X, Y, W, H, card, params)
    self.params = params

    Moveable:init(self, X, Y, W, H)

    self.CT = self.VT
    self.config = {
        card = card or {}
    }

    --might be factoried in another function or might even create a Sprite object in the engine
    --just loading temp image for now
    self.spritePath = card.spritePath

end

function Card:move(dt)
    Moveable.move(self, dt)
end



function cards:draw(cardarg)
   
    for _, card in ipairs(cards) do
        love.graphics.draw(card.sprite, card.transform.x, card.transform.y)
    end

end

function cards:update(dt)

    -- Checking if the card is being dragged (click while hovering the card)
    if love.mouse.isDown(1) then
        for _, card in ipairs(cards) do
            if love.mouse.getX() >= card.transform.x 
                and love.mouse.getX() <= card.transform.x + card.transform.width 
                and love.mouse.getY() >= card.transform.y 
                and love.mouse.getY() <= card.transform.y + card.transform.height 
            then
                card.dragging = true
            end
        end
    end

    -- If the card is being dragged, update its position to the mouse position
    for _, card in ipairs(cards) do
        if card.dragging then
            card.target_transform.x = love.mouse.getX() - card.transform.width / 2
            card.target_transform.y = love.mouse.getY() - card.transform.height / 2
        end
        move(card, dt)
    end
    

    -- If the mouse is released, stop dragging the card
    if not love.mouse.isDown(1) then
        for _, card in ipairs(cards) do
            card.dragging = false
        end
    end

end