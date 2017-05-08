
local nave = {
	
	posicaoX,
	posicaoY,
	design
	
}


function nave:criar() 

	self.posicaoX = display.contentWidth/2
	self.posicaoY = display.contentHeight - 20
	self.design = display.newCircle(self.posicaoX ,self.posicaoY  -  20, 10)
	
	return nave

end




function nave:moverEsquerda()

	self.design.x = self.design.x - 10
	
	
end


function nave:moverDireita()

	self.design.x = self.design.x + 10

end


return nave