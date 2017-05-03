
local nave = {
	
	posicaoX,
	posicaoY,
	design
	
}


function nave:criar() 

	nave.posicaoX = display.contentWidth/2
	nave.posicaoY = display.contentHeight - 20
	nave.design = display.newCircle(nave.posicaoX ,nave.posicaoY  - 20, 10)
	
	return nave

end

return nave