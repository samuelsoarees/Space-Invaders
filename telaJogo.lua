local composer = require("composer")

local scene = composer.newScene()

local widget = require("widget")

local espacoSideral = require("espacoSideral")

local physics = require("physics")

local sceneAliens

local tempo

local direcao = "direita"



function scene:create(event) 
	
	local sceneGroup = self.view
	sceneAliens = display.newGroup()

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


	-- Adiciona toda a tabela de alienigenas criados ao grupo especifico
	for i = 1 , #aliens do
		
		sceneAliens:insert(aliens[i].design)

	end

	--grupo da tela
	sceneGroup:insert(espacoSideral.nave.design)
	sceneGroup:insert(butaoD)
	sceneGroup:insert(butaoE)


	-- Move os alienigenas a cada um segundo
	tempo = timer.performWithDelay(1000,moverAliens, 0)	

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
		--timer.pause(tempo)


		end
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


function atirarNave(event)
	
	

end


function moverNaveEsquerda(event) 

	espacoSideral.nave:moverEsquerda()

end



function moverNaveDireita(event)

	espacoSideral.nave:moverDireita()

end


scene:addEventListener( "create", scene )

return scene