
alien = {
	
	posicaoX,
	posicaoY,
	design	

}

--[[function alien:criar(posicaoX,posicaoY,r1,r2) 

	self.posicaoX = display.contentWidth/2
	self.posicaoY = display.contentHeight/2

	

	return alien

end--]]



function alien:new()

	local novaAlien = {}

	setmetatable(novaAlien,{__index = alien})

	return novaAlien

end

return alien