local nave = require ("nave")
local alien = require ("alien")
local escudo = require("escudo")
local tiro = require("tiro")

espacoSideral  = {

	nave,
	escudo = {},
	alien = {},
	tiro

}

function espacoSideral:criar()

	self.nave = nave:criar()

end

function espacoSideral:criarEscudos()
	
	local posicaoX = display.contentWidth/4
	local posicaoY = display.contentHeight/5


	for i = 1 , 3 , 1 do
		local novoEscudo = escudo:new()

		novoEscudo.design = display.newCircle(posicaoX,(posicaoY*4),15)
		
		espacoSideral.escudo = novoEscudo

		posicaoX = posicaoX + 80

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

			table.insert(espacoSideral.alien, novoAlien)

			posicaoX = posicaoX + 20

		end

			posicaoX = display.contentWidth/4
			posicaoY = posicaoY + 20

	end


	return espacoSideral.alien

end



function espacoSideral:naveAtirar(posicaoNaveX,posicaoNaveY)

	self.tiro = tiro:new()

	self.tiro.design = display.newLine(posicaoNaveX,posicaoNaveY-20, posicaoNaveX , posicaoNaveY)
	
	return self.tiro.design

end


function espacoSideral:moverNaveEsquerda()

	self.nave.design.x = self.nave.design.x - 10

end


function espacoSideral:moverNaveDireita()

	self.nave.design.x = self.nave.design.x + 10

end



return espacoSideral