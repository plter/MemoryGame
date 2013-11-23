require("Game")
require("Config")

function Welcome()

	---
	--@type Welcome
	local self = {};

	function init ()

		---
		--@field [parent=#Welcome] #CCSize visibleSize The Design size
		self.visibleSize = CCDirector:sharedDirector():getVisibleSize()

		self.scene = CCScene:create()

		---
		--@field [parent=#Welcome] #CCLayer layer Binded layer
		self.layer = CCLayer:create()
		self.scene:addChild(self.layer)

		buildUI()

		self.layer:registerScriptTouchHandler(self.touchHandler)

		self.layer:setTouchEnabled(true)
	end

	function buildUI ()

		-----
		--@field [parent=#Welcome] #CCLabelTTF _btnStartGameLabel
		self._btnStartGameLabel = CCLabelTTF:create("Start Game","Courier",60)
		self.layer:addChild(self._btnStartGameLabel)
		self._btnStartGameLabel:setPosition(self.visibleSize.width/2,self.visibleSize.height/2)
	end

	self.touchHandler = function (eventType,x,y)
		if self._btnStartGameLabel:boundingBox():containsPoint(ccp(x,y)) then
			CCDirector:sharedDirector():replaceScene(Game().scene)
		end
	end


	init()
	return self
end


function main()

	CCEGLView:sharedOpenGLView():setDesignResolutionSize(Config.VISIBLE_WIDTH,Config.VISIBLE_HEIGHT,kResolutionShowAll)
	local director = CCDirector:sharedDirector()
	director:setDisplayStats(false)
	director:runWithScene(Welcome().scene)
end

main()