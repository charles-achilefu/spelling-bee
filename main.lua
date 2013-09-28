Vector = require "libs.hump.vector"
Timer = require "libs.hump.timer"
require "libs.LoveFrames"

function love.load()
	score		= 0
	numWords	= 5
	textboxes	= {}
	
	words = {
		"lorem",
		"ipsum",
		"dolor",
		"sit",
		"amet",
	}
	
	speed = {
		min = 1,
		max = 3,
	}
	
	input = loveframes.Create("textinput")
	input:SetPos(400-40, 600-30)
	input:SetWidth(80)
	
	for i = 1, numWords do
		local spawn = math.random(speed.min, speed.max) * i
		Timer.add(spawn, newWord)
	end
end

function love.update(dt)
	Timer.update(dt)
	
	for k, word in pairs(textboxes) do
		if input:GetText() == word:GetText() then
			success(k)
		end
	end
	
	loveframes.update(dt)
end

function love.draw()
	love.graphics.print("SCORE: " .. score, 0, 0)
	
	if score == numWords then
		love.graphics.print("A WINRAR IS YOU!", 350, 290)
	end
	
	loveframes.draw()
end

function love.keypressed(key, unicode)
	loveframes.keypressed(key, unicode)
end

function love.keyreleased(key)
	loveframes.keyreleased(key)
end

function love.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
end
 
function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end

function newWord()
	local word = math.random(1, #words)
	local pos = Vector(1,1) * math.random(50, 500)
	
	local box = loveframes.Create("textinput")
	box:SetText(words[word])
	box:SetPos(pos.x, pos.y)
	box:SetWidth(80)
	
	table.remove(words, word)
	table.insert(textboxes, box)
end

function success(key)
	score = score + 1
	input:Clear()
	textboxes[key]:Remove()
	textboxes[key] = nil
end