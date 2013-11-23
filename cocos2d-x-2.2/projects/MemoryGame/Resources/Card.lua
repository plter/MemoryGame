require("Config")

function Card(num)

	---
	--@type Card
	local self = CCSprite:create()
	local recto = CCLabelTTF:create(num,"Courier",Config.CARD_NUM_FONT_SIZE)
	local verso = CCSprite:create()
	
	
	function init()
		self.cardNum = num
		
		self:setAnchorPoint(ccp(0,0))
		self:setContentSize(CCSizeMake(Config.CARD_WIDTH,Config.CARD_HEIGHT))
		
		verso:setTextureRect(CCRectMake(5,5,Config.CARD_WIDTH-10,Config.CARD_HEIGHT-10))
		verso:setColor(ccc3(255,255,255))
		verso:setAnchorPoint(ccp(0,0))
		self:addChild(verso)
		
		recto:setPosition(ccp(Config.CARD_WIDTH/2,Config.CARD_HEIGHT/2))
		self:addChild(recto)
		
		self:showRecto()
	end
	
	
	self.showRecto = function ()
		recto:setVisible(true)
		verso:setVisible(false)
	end
	
	self.showVerso = function ()
		recto:setVisible(false)
		verso:setVisible(true)
	end
	
	
	init()
	return self
end