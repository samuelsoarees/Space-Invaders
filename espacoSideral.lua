local nave = require ("nave")
local alien = require ("alien")
local escudo = require("escudo")
local tiro = require("tiro")

espacoSideral  = {

	nave,
	escudo = {},
	alien = {},
	tiro,
	tiroAlien

}

function espacoSideral:criar()

	self.nave = nave:criar()
	self.nave.design.id = "nave"
	return self.nave

end


function espacoSideral:posicionaEscudos()
	local posicaoX = display.contentWidth/5
	
	local posicaoY = display.contentHeight/5


	for i = 1, 3 do

		espacoSideral:criarEscudo(posicaoX,posicaoY)

		posicaoX = posicaoX + 80
	end

	return espacoSideral.escudo
end


function espacoSideral:criarEscudo(posicaoX,posicaoY)
	
	for i = 1, 5 do
		s = posicaoX
		for j = 1, 5 do
		
			local novoEscudo =  escudo:new()

			novoEscudo.design = display.newRect(s,(posicaoY*4),6,6)
			physics.addBody(novoEscudo.design,{friction = 1, bounce = 0})
			table.insert(espacoSideral.escudo, novoEscudo)
			s = s + 7
			
		end
		
		s = display.contentWidth/5
		posicaoY = posicaoY +2

	end
end



--Cria todos os aliens e adiciona na tabela de espacoSideral
function espacoSideral:criarAliens()
	
	local posicaoX = display.contentWidth/4
	local posicaoY = display.contentHeight/4

	for i = 1, 4 , 1 do

		for j = 1 , 8, 1 do

			local novoAlien = alien:new()		
			
			novoAlien.posicaoX = posicaoX
			novoAlien.posicaoY = posicaoY
			novoAlien.design = display.newRect(posicaoX,posicaoY,15,15)

			physics.addBody(novoAlien.design,{friction = 1, bounce = 0})

			novoAlien.design.isFixedRotation = true

			table.insert(espacoSideral.alien, novoAlien)

			posicaoX = posicaoX + 20

		end

			posicaoX = display.contentWidth/4
			posicaoY = posicaoY + 20

	end


	return espacoSideral.alien

end



function espacoSideral:aliensAtirar(posicaoX,posicaoY)

	self.tiroAlien = tiro:new()
	self.tiroAlien.design = display.newLine(posicaoX,posicaoY-20, posicaoX , posicaoY -5)
	physics.addBody(self.tiroAlien.design,{friction = 1, bounce = 0})
	return self.tiroAlien.design

end



function espacoSideral:naveAtirar(posicaoNaveX,posicaoNaveY)

	self.tiro = tiro:new()

	self.tiro.design = display.newLine(posicaoNaveX,posicaoNaveY-20, posicaoNaveX , posicaoNaveY - 15)

	physics.addBody(self.tiro.design,{friction = 1, bounce = 0})
	
	return self.tiro.design

end


function espacoSideral:moverNaveEsquerda()

	self.nave.design.x = self.nave.design.x - 10

end


function espacoSideral:moverNaveDireita()

	self.nave.design.x = self.nave.design.x + 10

end



return espacoSideral