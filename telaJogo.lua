local composer = require("composer")

local scene = composer.newScene()

local widget = require("widget")

local espacoSideral = require("espacoSideral")

local physics = require("physics")


local sceneAliens

local tempo



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
	tempo = timer.performWithDelay(1000,moverAliens, 0)	

end


--Move os alienigenas na tela
function moverAliens()
	local retorno = colisao()
	
	if retorno == 1 then
		-- mover o grupo x,y
		sceneAliens:translate(10,0)

	else

		timer.pause(tempo)
	end
	
	
end


--Verifica a colisao nas paredes
function colisao()
	
	local retorno = false

	-- for para verificar se cada alien esta colidindo com a parede
	for i = 1 , sceneAliens.numChildren do
		
		-- Variaveis que vão obter posição x e y de cada elemento do grupo
		local x , y = sceneAliens[i]:localToContent(0,0) 
		
		if  x < display.contentWidth  then
		
			retorno = true

		else 
			retorno = false

		end

	end


	if retorno == true then
		return 1 

	else 

		return 0

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