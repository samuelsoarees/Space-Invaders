local composer = require("composer")

local scene = composer.newScene()

local widget = require("widget")

local espacoSideral = require("espacoSideral")

local physics = require("physics")

local tiroNave = {}

local sceneAliens

local tempoAlien

local direcao = "direita"



function scene:create(event) 
	
	local sceneGroup = self.view

	myImage = display.newImage( "Space.jpg" )
	sceneAliens = display.newGroup()
	sceneTiros = display.newGroup()

	--cria a nave espacial
	espacoSideral:criar()

	--tabela com todos os alienigenas criados
	local aliens = espacoSideral:criarAliens()

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


	-- Adiciona toda a tabela de alienigenas criados ao grupo especifico
	for i = 1 , #aliens do
		
		--sceneAliens:insert(aliens[i].design)
		--aliens[i].design.collision =  colisaoTiro
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


--Move os alienigenas na tela
function moverAliens()
	local colisaoDireita = colisaoDireita()
	local colisaoEsquerda = colisaoEsquerda()


	if direcao == "direita" then

		if colisaoDireita ~= true then
			-- mover o grupo x,y
			sceneAliens:translate(10,0)

		else

			sceneAliens:translate(0,10)
			direcao = "esquerda"

		end	

	elseif direcao == "esquerda" then

		if colisaoEsquerda ~= true then
			
			sceneAliens:translate(-10,0)

		else	

			sceneAliens:translate(0,10)
			direcao = "direita"
		


		end
	elseif direcao == "baixo" then

		timer.pause(tempoAlien)


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
		--tiroNave.design:addEventListener("collision", colisaoTiro)
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


function moverNaveEsquerda(event) 

	espacoSideral:moverNaveEsquerda()

end



function moverNaveDireita(event)

	espacoSideral:moverNaveDireita()

end


scene:addEventListener( "create", scene )



return scene