

local escudo = {
	
	design

}



function escudo:new()
	
	local novoEscudo = {}

	setmetatable(novoEscudo,{__index = alien})

	return novoEscudo

end





return  escudo