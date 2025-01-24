local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

--list of the different cards instanciated
cards = {}


function cards:newCard()
    print("card.lua")
    local card = {}

    card.dragging = false
    card.transform = {
        x = (screenWidth - 179) / 2,
        y = (screenHeight - 250) / 2,
        width = 179,
        height = 250
    }
    card.target_transform = {
        x = (screenWidth - 179) / 2,
        y = (screenHeight - 250) / 2,
        width = 179,
        height = 250
    }
    card.velocity = {
        x = 0,
        y = 0
    }
    card.sprite = love.graphics.newImage("assets/backCard.png")
    
    table.insert(cards, card)
end

-- Function to move the card to the target position
local function move(card, dt)
    local momentum = 0.4
    local max_velocity = 10
    
    print("card.lua")

    if (card.target_transform.x ~= card.transform.x or card.velocity.x ~= 0) or
        (card.target_transform.y ~= card.transform.y or card.velocity.y ~= 0) 
    then
        card.velocity.x = momentum * card.velocity.x +
            (1 - momentum) * (card.target_transform.x - card.transform.x) * 30 * dt
        card.velocity.y = momentum * card.velocity.y +
            (1 - momentum) * (card.target_transform.y - card.transform.y) * 30 * dt
        card.transform.x = card.transform.x + card.velocity.x
        card.transform.y = card.transform.y + card.velocity.y

        

    end

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