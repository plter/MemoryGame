
require("Card")
require("Config")
require("Success")

function Game()
	---
	--@type Game
	local self = {}
	local cardArr = {}
	local allPoints
	local currentNum = 1
	local nextLevelLabel,resetGameLabel
	local layer,visibleSize,currentLevel

	function init ()
	
		visibleSize = CCDirector:sharedDirector():getVisibleSize()
	
		---
		--@field [parent=#Game] scene
		self.scene = CCScene:create()
		---
		--@field [parent=#Game] layer
		layer = CCLayer:create()
		layer:registerScriptTouchHandler(onTouch)
		layer:setTouchEnabled(true)
		self.scene:addChild(layer)
		
		nextLevelLabel = CCLabelTTF:create("Success\nClick for next level","Courier",Config.LABEL_FONT_SIZE)
		nextLevelLabel:setPosition(ccp(visibleSize.width/2,visibleSize.height/2))
		layer:addChild(nextLevelLabel)
		
		resetGameLabel = CCLabelTTF:create("Fail\nClick to reset game","Courier",Config.LABEL_FONT_SIZE)
		resetGameLabel:setPosition(ccp(visibleSize.width/2,visibleSize.height/2))
		layer:addChild(resetGameLabel)

		resetGame()
		startGame(1)
	end
	
	function resetGame()
		currentLevel = 1
	end

	function startGame(level)
		nextLevelLabel:setVisible(false)
		resetGameLabel:setVisible(false)
	
		currentNum = 1
		genAllPoints()

		local c,p,randNum

		math.randomseed(os.time())

		for var=1, level+2 do
			c = Card(var)
			table.insert(cardArr,1,c)
			layer:addChild(c)

			randNum = math.ceil(math.random()*table.maxn(allPoints))
			p = allPoints[randNum]
			table.remove(allPoints,randNum)

			c:setPosition(p)
		end

	end
	
	function nextLevel()
		currentLevel=currentLevel+1
		startGame(currentLevel)
	end

	function genAllPoints()

		allPoints = {}

		for i=0, Config.MAX_H_NUM-1 do
			for j=0, Config.MAX_V_NUM-1 do
				table.insert(allPoints,1,ccp(Config.CARD_WIDTH*i,Config.CARD_HEIGHT*j))
			end
		end
	end

	function turnAllCardsOver()

		for key, var in pairs(cardArr) do
			var:showVerso()
		end
	end
	
	function clearCards()
		
		while table.maxn(cardArr)>0 do
			layer:removeChild(table.remove(cardArr,1),true)
		end
	end
	
	function showNextLevelLabel()
		nextLevelLabel:setVisible(true)
	end
	
	function showResetGameLabel()
		resetGameLabel:setVisible(true)
	end

	function onTouch(eventType,x,y)

		local point = ccp(x,y)
		
		---
		--buttons
		if nextLevelLabel:isVisible() and 
			nextLevelLabel:boundingBox():containsPoint(point) then
			nextLevel()
			return
		elseif resetGameLabel:isVisible() and 
			resetGameLabel:boundingBox():containsPoint(point) then
			resetGame()
			startGame(currentLevel)	
			return
		end
		
		---
		--Cards
		for key, var in pairs(cardArr) do
			if var:boundingBox():containsPoint(point) then
				if currentNum==var.cardNum then
					layer:removeChild(var,true)
					table.remove(cardArr,key)
					
					if table.maxn(cardArr)<=0 then
						if currentLevel<=Config.MAX_LEVEL then
							showNextLevelLabel()
						else
							CCDirector:sharedDirector():replaceScene(Success().scene)
						end
					end

					if currentNum==1 then
						turnAllCardsOver()
					end

					currentNum = currentNum+1
				else
					clearCards()
					showResetGameLabel()
				end

				return
			end
		end
	end

	init()
	return self
end