LevelMaker = Class{}

function LevelMaker.createMap(Level)
	local bricks = {}

	--randomly choose between 1-5 rows and 7-13 columns
	local numRows = math.random(1, 5)

	local numCols = math.random(7, 13)

	--lay out bricks in a bricky formation, simple y x y style

	for y = 1, numRows do
		for x = 1, numCols do
			b = Brick(
				(x-1) * 32 + 7 + (13 - numCols) * 16, y * 16)

			table.insert(bricks, b)
		end
	end

	return bricks
end