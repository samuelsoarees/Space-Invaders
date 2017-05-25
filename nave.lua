local physics = require ("physics")
local class = require("30log")

local nave = class("nave", {
	
	posicaoX,
	posicaoY,
	design
	
}

)


function nave:criar() 

	self.posicaoX = display.contentWidth/2
	self.posicaoY = display.contentHeight - 20
	self.design = display.newCircle(self.posicaoX ,self.posicaoY  -  20, 10)


	physics.start(true)
	physics.setGravity(0,0)
	physics.addBody(nave.design,{friction = 1, bounce = 0})
	
	return nave

end


function nave:moverEsquerda()

	self.design.x = self.design.x - 10
	
	
end


function nave:moverDireita()

	self.design.x = self.design.x + 10

end


return nave