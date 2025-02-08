---@class Node: Object
Node = Object:extend()

-- A Node is the most high level object class of every object in the project

-- Constructor of the Node object
---@param args {config: table, T: {x: number, y: number, w: number, h: number}}
function Node:init(args)

    --getting the arguments 
    -- NOTE : les arguments sont peut etre mal déclaré et peuvent peut etre engendrer des bugs
    self.args = args or {}

    --get config, metadatas for the Node object
    self.config = args.config or {}

    --get the position of the node
    self.T = {
        x = args.T.x or 0, -- x position
        y = args.T.y or 0, -- y position
        w = args.T.w or 0, -- width
        h = args.T.h or 0,  -- height
        scale = args.T.scale or 0 -- scale
    }

    -- position used for target position
    self.CT self.T

    -- ID tracker, might be used
    G.ID = G.ID or 1
    self.ID = G.ID
    G.ID = G.ID + 1

    -- states of the object to manage visibility and interaction
    self.states = {
        visible = {is = true, can = true},
        collide = { is = false, can = false},
        hover = { is = false, can = true},
        click = { is = false, can = true},
        drag = { is = false, can = true},
        release_on = { is = false, can = true}
    }

    -- children, the nodes have a tree structure
    if not self.children then
        self.children = {}
    end


end

-- Draw the node and every of its childrens
function Node:draw()
    if self.states.visible.is then
        addToDrawHash(self)
        for _, child in ipairs(self.children) do
            child:draw()
        end
    end
end


---@param pos {x: number, y:number}
function Node:isObjectColidingWith(pos)
    if (pos.x >= self.T.x)
        and (pos.x <= self.T.x + self.T.w) 
        and (pos.y >= self.T.y)
        and (pos.y <= self.T.y + self.h) 
    then
        return(true)
    else
        return(false)
end

--TODO REMOVE FUNCTION

--Prototypes

function Node:update(dt) end
function Node:click() end
function Node:animate() end