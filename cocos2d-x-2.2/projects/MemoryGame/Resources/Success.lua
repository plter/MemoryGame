function Success()
	local self = {}
	self.scene = CCScene:create()
	
	local layer = CCLayer:create()
	layer:registerScriptTouchHandler( function (eventType,x,y)
		CCDirector:sharedDirector():replaceScene(Welcome().scene)
	end )
	layer:setTouchEnabled(true)
	self.scene:addChild(layer)
	
	local visibleSize = CCDirector:sharedDirector():getVisibleSize()
	
	local mn = CCSprite:create("mn.jpg")
	mn:setPosition(ccp(visibleSize.width/2,visibleSize.height/2))
	layer:addChild(mn)
	
	local successLabel = CCLabelTTF:create("You succeed\nClick here to restart","Courier",Config.LABEL_FONT_SIZE)
	successLabel:setPosition(ccp(visibleSize.width/2,visibleSize.height/2))
	layer:addChild(successLabel)
	
	return self
end