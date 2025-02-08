--- This file is used to store miscellaneous functions that are used in the project.


-- Function to add a node to the draw hash
-- This function should be called every time an object is set to be visible (in the draw function)
-- The draw hash is used to be pass through to find obect(s) in collision with the cursor
function addToDrawHash(obj)
    if obj then
        G.DRAW_HASH[#G.DRAW_HASH + 1] = obj --adding the object to the last position
    end
end