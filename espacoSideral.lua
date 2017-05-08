
local nave = require ("nave")
local alien = require ("alien")

espacoSideral  = {

	nave,
	alien

}


function espacoSideral:criar()

	self.nave = nave:criar()
	self.alien = alien:criar()

end

return espacoSideral


