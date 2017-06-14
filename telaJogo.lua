local composer = require("composer")

local scene = composer.newScene()

local widget = require("widget")

local espacoSideral = require("espacoSideral")

local cAliensMove = require("controllerAliensMove")

local physics = require("physics")

local tiroNave = {}

local aliens

local tempoAlien

local direcao = "direita"


-- Criação da cena
-- ===========================================================================================================================================================
function scene:create(event) 
	
	local sceneGroup = self.view

	myImage = display.newImage( "Space.jpg" )
	sceneAliens = display.newGroup()
	sceneTiros = display.newGroup()

	--cria a nave espacial
	espacoSideral:criar()

	--tabela com todos os alienigenas criados
	aliens = espacoSideral:criarAliens()

	espacoSideral:criarEscudos()

	
	local butaoD = widget.newButton({x =(display.contentWidth/4)*3 ,y =display.contentHeight/3 ,width = display.contentWidth/2, height = display.contentHeight/4 * 2  ,onRelease = moverNaveDireita})
	local butaoE = widget.newButton({x =display.contentWidth/4 ,y =display.contentHeight/3 ,width = display.contentWidth/2, height = display.contentHeight/4 *2 ,onRelease = moverNaveEsquerda})
	local atirar = widget.newButton({x =display.contentWidth/2 ,y =display.contentHeight/4 *3 ,width = display.contentWidth, height = display.contentHeight/4 ,onRelease = atirarNave})

	
	local linhaDireita= display.newLine(display.contentWidth, 0 , display.contentWidth , display.contentHeight )
	local linhaEsquerda = display.newLine(0,0,0,display.contentHeight)

	

	physics.start(true)
	
	physics.addBody(linhaDireita, "static", { friction = 1, bounce = 0 })

	physics.addBody(linhaEsquerda, "static", { friction = 1, bounce = 0 })		

	physics.setGravity(0,0)
	--physics.setDrawMode("hybrid")


	-- Adiciona colisao aos aliens
	for i = 1 , #aliens do
		
		aliens[i].design:addEventListener("collision", colisaoTiro)

	end

	--grupo da tela
	sceneGroup:insert(myImage)
	sceneGroup:insert(espacoSideral.nave.design)
	sceneGroup:insert(butaoD)
	sceneGroup:insert(butaoE)


	-- Move os alienigenas a cada um segundo
	tempoAlien = timer.performWithDelay(1000,moverAliens, 0)	
	
	
	tempoTiro = timer.performWithDelay(0005,moverTiroNave, 0)	

end

-- =====================================================================================================================================================


--Movimentações de alienigenas na tela 
-- ====================================================================================================================================================
--Move os alienigenas na tela
function moverAliens()
	
	if direcao == "direita" then
		moverAliensEsquerda()
	end	

end


function moverAliensEsquerda()

	for i = 1 , #aliens do

		aliens[i].design.x = aliens[i].design.x + 10

	end


end


--Verifica a colisao dos aliens nas paredes a esquerda
function colisaoEsquerda()
	
	for i = 1, sceneAliens.numChildren do

		local x,y = sceneAliens[i]:localToContent(0,0)

		if x == 10 then
			
			return true

		end	

	end

end



--Verifica a colisao dos aliens nas paredes a direita
function colisaoDireita()

	for i = 1 , sceneAliens.numChildren do
		
		local x , y = sceneAliens[i]:localToContent(0,0) 
		
		if  x == (display.contentWidth - 10)  then
		
			return true
	
		end

	end
	
end

-- =====================================================================================================================================================




-- Movimentação dos tiros 
-- ====================================================================================================================================================
function removerTiro()
	
	if tiroNave.design ~= nil and tiroNave.design.y <= 0  then

		tiroNave.design:removeSelf()

		tiroNave.design = nil

		return true

	end

end


function moverTiroNave()
	
	if tiroNave.design ~= nil then

		tiroNave.design.y= tiroNave.design.y-10

	end


	if removerTiro() == true then
		timer.pause(tempoTiro)

	end

end



function atirarNave(event)
	
	if tiroNave.design ==nil then
		
		tiroNave.design = espacoSideral:naveAtirar(espacoSideral.nave.design.x,espacoSideral.nave.design.y)
		tiroNave.collision = colisaoTiro
		timer.resume(tempoTiro)


	end

end


function colisaoTiro(event)
	
	if event.phase == "began" then

		timer.pause(tempoTiro)
		tiroNave.design:removeSelf()
		tiroNave.design = nil
		event.target:removeSelf()

	end

end

-- ===========================================================================================================================================================




-- Movimento da nave
-- ===========================================================================================================================================================

function moverNaveEsquerda(event) 

	espacoSideral:moverNaveEsquerda()

end



function moverNaveDireita(event)

	espacoSideral:moverNaveDireita()

end
-- ===========================================================================================================================================================

scene:addEventListener( "create", scene )



return scene