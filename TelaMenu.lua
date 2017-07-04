local composer = require("composer")

local scene = composer.newScene()

local widget = require("widget")



function scene:create(event)

	sceneGroup = self.view


	
	

	local titulo = display.newText({text = "Space Invaders", x = display.contentWidth/2, y = display.contentHeight/10, fontSize = 40})

	local play = display.newText({text = "Play", x = display.contentWidth/2, y = display.contentHeight/2 - 50, fontSize = 25})
    play:setFillColor(1,1,1)


	botaoPlay = widget.newButton(
    	{	x = display.contentWidth/2,
    		y = display.contentHeight/2,
       		width = 200,
        	height = 120,
        	defaultFile = "Imagens/play.png",
        	onEvent = inicioJogo
    	}
	)

	--sceneGroup:insert(myImage)
	sceneGroup:insert(botaoPlay)
	sceneGroup:insert(play)
	sceneGroup:insert(titulo)

end



function inicioJogo(event)

	if event.phase == "began" then
		composer.gotoScene("telaJogo")

	end

end



scene:addEventListener( "create", scene )

return scene