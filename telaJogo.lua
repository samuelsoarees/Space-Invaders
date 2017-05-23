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

	
	butaoD = widget.newButton({x =(display.contentWidth/4)*3 ,y =display.contentHeight/2 ,width = display.contentWidth/2, height = display.contentHeight  ,onRelease = moverDireita})
	butaoE = widget.newButton({x =display.contentWidth/4 ,y =display.contentHeight/2 ,width = display.contentWidth/2, height = display.contentHeight ,onRelease = moverEsquerda})
	
	
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
	tempo = timer.performWithDelay(5000,moverAliens, 0)	

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



function colisaoEsquerda()
	
	for i = 1, sceneAliens.numChildren do

		local x,y = sceneAliens[i]:localToContent(0,0)

		if x == 10 then
			
			return true

		end	

	end

end



--Verifica a colisao nas paredes
function colisaoDireita()

	-- for para verificar se cada alien esta colidindo com a parede
	for i = 1 , sceneAliens.numChildren do
		
		-- Variaveis que vão obter posição x e y de cada elemento do grupo
		local x , y = sceneAliens[i]:localToContent(0,0) 
		
		if  x == (display.contentWidth - 10)  then
		
			return true
	
		end

	end

	
end


function moverEsquerda(event) 

	espacoSideral.nave:moverEsquerda()

end



function moverDireita(event)

	espacoSideral.nave:moverDireita()

end


scene:addEventListener( "create", scene )

return scene