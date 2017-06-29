local composer = require("composer")

local scene = composer.newScene()

local widget = require("widget")

local espacoSideral = require("espacoSideral")

local physics = require("physics")

local tiroNave = {}

local aliens

local tempoAlien

local direcao = "direita"

local pontos 

local vidas

-- Criação da cena
-- ===========================================================================================================================================================
function scene:create(event) 
	
	local sceneGroup = self.view

	myImage = display.newImage( "Imagens/Space.jpg" )
	sceneAliens = display.newGroup()
	sceneTiros = display.newGroup()

	local linhaCima = display.newLine(0,display.contentHeight/7 * 1  , display.contentWidth , display.contentHeight/7 * 1 )
	
	local textPontos =  display.newText({text = "Pontos:", x = display.contentWidth/7 * 4.7, y = display.contentHeight/7 - 15, fontSize = 20})
	pontos =  display.newText({text = "0", x = display.contentWidth/7 * 6, y = display.contentHeight/7 - 15, fontSize = 20})
	
	local textVidas = display.newText({text = "Vidas:", x = display.contentWidth/7 * 1, y = display.contentHeight/7 - 15, fontSize = 20})
	vidas = display.newText({text = "3", x = display.contentWidth/7 * 2, y = display.contentHeight/7 - 15, fontSize = 20})


	--cria a nave espacial
	espacoSideral:criar()

	--tabela com todos os alienigenas criados
	aliens = espacoSideral:criarAliens()

	
	espacoSideral:posicionaEscudos()

	
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

	--grupo da tela
	sceneGroup:insert(myImage)
	sceneGroup:insert(espacoSideral.nave.design)
	sceneGroup:insert(butaoD)
	sceneGroup:insert(butaoE)
	sceneGroup:insert(linhaCima)
	sceneGroup:insert(pontos)


	-- Move os alienigenas a cada um segundo
	tempoAlien = timer.performWithDelay(0500,moverAliens, 0)	
	
	
	tempoTiro = timer.performWithDelay(0005,moverTiroNave, 0)	

end

-- =====================================================================================================================================================


--Movimentações de alienigenas na tela 
-- ====================================================================================================================================================
--Move os alienigenas na tela
function moverAliens()
	
	if direcao == "direita" then
		
		moverAliensDireita()

	elseif direcao == "esquerda" then

		moverAliensEsquerda()
	end

	if direcao == "baixo" then
		moverAliensBaixo()
	end

end


function moverAliensDireita()
	local colisaoDireita = colisaoDireita()
	if colisaoDireita ~= true then
		for i = 1 , #aliens do
			if aliens[i].design.x ~=nil then
			
				aliens[i].design.x = aliens[i].design.x + 10	

			end
		end
	else
			
			moverAliensBaixo()
			direcao ="esquerda"

	end

end

--Verifica a colisao dos aliens nas paredes a direita
function colisaoDireita()

	for i = 1 , #aliens do
		if aliens[i].design.x ~=nil then				
			if  aliens[i].design.x >= (display.contentWidth - 20)  then
		
				return true
	
			end
		end

	end
	
end

--Mover aliens esquerda
function moverAliensEsquerda()
	local colisaoEsquerda = colisaoEsquerda()
	if colisaoEsquerda ~= true then
		for i = 1, #aliens do
			if aliens[i].design.x ~= nil then
	
				aliens[i].design.x = aliens[i].design.x - 10

			end
		end

	else
		moverAliensBaixo()

		direcao = "direita"

	end

end

function colisaoEsquerda()

	for i = 1, #aliens do
		if aliens[i].design.x ~= nil then
			if aliens[i].design.x <=20 then 

				return true

			end
		end
	end

end


-- Mover aliens para baixo
function moverAliensBaixo()
	
	for i = 1, #aliens do
		
		if aliens[i].design.y ~= nil then
		
			aliens[i].design.y = aliens[i].design.y + 10 

		end

	end


end


function colisaoBaixo()

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
		tiroNave.design:addEventListener("collision", colisaoTiro)
		timer.resume(tempoTiro)
		
		local somtiro = audio.loadSound( "Sons/shoot.wav" )
	
		local toqueSom = audio.play(somtiro)

	end

end


function colisaoTiro(event)
	
	if event.phase == "began" then

		local somdestruicao = audio.loadSound( "Sons/invaderkilled.wav" )
	
		local toqueSom = audio.play(somdestruicao)

		timer.pause(tempoTiro)
		tiroNave.design:removeSelf()
		tiroNave.design = nil
		event.other:removeSelf()
		pontos.text = pontos.text + 10

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