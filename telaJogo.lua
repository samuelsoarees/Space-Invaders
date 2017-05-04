local composer = require("composer")

local scene = composer.newScene()

local widget = require("widget")

local espacoSideral = require("espacoSideral")



function scene:create(event) 

	
	local sceneGroup = self.view
	
	espacoSideral:criar()
	
	butaoD = widget.newButton({x =(display.contentWidth/4)*3 ,y =display.contentHeight/2 ,width = display.contentWidth/2, height = display.contentHeight  ,onRelease = moverDireita})
	butaoE = widget.newButton({x =display.contentWidth/4 ,y =display.contentHeight/2 ,width = display.contentWidth/2, height = display.contentHeight ,onRelease = moverEsquerda})
	
	sceneGroup:insert(espacoSideral.nave.design)
	sceneGroup:insert(butaoD)
	sceneGroup:insert(butaoE)
	
	
end




function moverEsquerda(event) 

		espacoSideral.nave:moverEsquerda()

end



function moverDireita(event)

	espacoSideral.nave:moverDireita()

end


scene:addEventListener( "create", scene )

return scene