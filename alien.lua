
alien = {
	
	posicaoX,
	posicaoY,
	design	

}




function alien:criar() 

	self.posicaoX = display.contentWidth/2
	self.posicaoY = display.contentHeight/2

	self.design = display.newCircle(self.posicaoX ,self.posicaoY  -  20, 30)

	return alien

end



return alien



