
local alien = {
	
	posicaoX,
	posicaoY,
	design	

}

function alien:new()

	local novaAlien = {}

	setmetatable(novaAlien,{__index = alien})

	return novaAlien

end

return alien