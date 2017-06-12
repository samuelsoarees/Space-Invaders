local physics = require ("physics")
local class = require("30log")

local nave = class("nave", {
	
	design
	
}

)

function nave:criar() 

	self.design = display.newCircle(display.contentWidth/2 ,display.contentHeight - 40, 10)


	physics.start(true)
	physics.setGravity(0,0)
	physics.addBody(nave.design,{friction = 1, bounce = 0})
	nave.design.isFixedRotation = true
	
	return nave

end

return nave