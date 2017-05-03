local composer = require("composer")

local scene = composer.newScene()

local widget = require("widget")

local espacoSideral = require("espacoSideral")



function scene:create(event) 

	
	local sceneGroup = self.view
	
	espacoSideral:criar()
	
	sceneGroup:insert(espacoSideral.nave.design)
	
end


scene:addEventListener( "create", scene )

return scene