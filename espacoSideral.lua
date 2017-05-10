local nave = require ("nave")
local alien = require ("alien")

espacoSideral  = {

	nave,
	alien = {}

}

function espacoSideral:criar()

	self.nave = nave:criar()

	
end




function espacoSideral:criarAliens()
	local posicaoX = display.contentWidth/4
	local posicaoY = display.contentHeight/4

	for i = 1, 4 , 1 do

		for j = 1 , 8, 1 do

			novoAlien = alien:new()		
			novoAlien.design = display.newRect(posicaoX,posicaoY,15,15)

			espacoSideral.alien = novoAlien

			posicaoX = posicaoX + 20

		end

			posicaoX = display.contentWidth/4
			posicaoY = posicaoY + 20

	end




end


return espacoSideral