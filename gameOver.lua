local composer = require("composer")

local widget = require("widget")

local scene = composer.newScene()


function scene:create(event)

	local sceneGroup = self.view
	--print(event.params.pontos)

	local rect = display.newRect( display.contentWidth/2,display.contentHeight/7*3,display.contentWidth, display.contentHeight/7*2 )
	local textGameOver = display.newText("Game Over!!", display.contentWidth/2,display.contentHeight/7 *2.6,native.systemFont, 30)
	local textPontos = display.newText("Pontuação: "..event.params.pontos, display.contentWidth/2,display.contentHeight/7 *3.4,native.systemFont,25)	
	local butonReinicio = widget.newButton({label = "Reiniciar",onRelease = reiniciaJogo,labelColor = { default={ 1, 1, 1, 1 }, over={1, 1, 1} }, x = display.contentWidth/2, y = display.contentHeight/ 2.6 * 2, width = display.contentWidth/1.5, height = display.contentHeight/12, shape = "roundedRect", fillColor = { default={ 0.2, 0.2, 1, 0 }, over={ 0.8, 0.8, 1 } } })


	textGameOver:setFillColor(0,0,0)
	textPontos:setFillColor(0,0,0)
	
	sceneGroup:insert(rect)
	sceneGroup:insert(textGameOver)
	sceneGroup:insert(textPontos)
	sceneGroup:insert(butonReinicio)
end

function reiniciaJogo()
	composer.gotoScene("telaJogo")
end


scene:addEventListener("create", scene)

return scene