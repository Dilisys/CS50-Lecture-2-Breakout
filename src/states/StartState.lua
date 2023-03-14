StartState = Class{__includes = BaseState}


--which of the 2 menu options are highlighted
local highlighted = 1

function StartState:update(dt)

	if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
		--Ternary operation. if 1 then go to 2, otherwise 1
		highlighted = highlighted == 1 and 2 or 1
		gSounds['paddle-hit']:play()
	end

	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gSounds['confirm']:play()

		if highlighted == 1 then
			gStateMachine:change('play')
		end
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function StartState:render()

	--title
	love.graphics.setFont(gFonts['large'])
	love.graphics.printf("BREAKOUT!", 0, VIRTUAL_HEIGHT / 3,
		VIRTUAL_WIDTH, 'center')

	--menu items
	love.graphics.setFont(gFonts['medium'])

	--START menu item
	if highlighted == 1 then
		love.graphics.setColor(103/255, 1, 1, 1)
	end

	love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70,
		VIRTUAL_WIDTH, 'center')

	love.graphics.setColor(1, 1, 1, 1)

	--HIGH SCORE menu item
	if highlighted == 2 then
		love.graphics.setColor(103/255, 1, 1, 1)
	end

	love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90,
		VIRTUAL_WIDTH, 'center')

	love.graphics.setColor(1, 1, 1, 1)
end