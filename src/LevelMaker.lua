LevelMaker = Class{}

--whole brick patterns
NONE = 1
SINGLE_PYRAMID = 2
MULTI_PYRAMID = 3

--per-row patterns
SOLID = 1 --same color in row
ALTERNATE = 2 --alternate colors
SKIP = 3 --skip every other block
NONE = 4 --no blocks

function LevelMaker.createMap(level)
	local bricks = {}

	--randomly choose between 1-5 rows and 7-13 columns
	local numRows = math.random(1, 5)

	local numCols = math.random(7, 13)
	--make sure number of columns is odd
	numCols = numCols % 2 == 0 and (numCols + 1) or numCols

	--highest tier brick this level, max 3
	local highestTier = math.min(3, math.floor(level / 5))

	--highest color brick this level, max 5
	local highestColor = math.min(5, level % 5 + 3)

	--lay out bricks
	for y = 1, numRows do
		--should we do skipping for this row?
		local skipPattern = coinFlip()

		--should we alternate colors?
		local alternatePattern = coinFlip()

		--choose 2 alternate colors and tiers
		local alternateColor1 = math.random(1, highestColor)
		local alternateColor2 = math.random(1, highestColor)
		local alternateTier1 = math.random(0, highestTier)
		local alternateTier2 = math.random(0, highestTier)

		--whether we skip the first block or not
		local skipFlag = coinFlip()

		--what color the alternated block starts as
		local alternateFlag = coinFlip()

		--solid colors
		local solidColor = math.random(1, highestColor)
		local solidTier = math.random(0, highestTier)

		for x = 1, numCols do
			if skipPattern and skipFlag then
				skipFlag = not skipFlag

				--no continue statement in lua, so use this instead
				goto continue
			else
				skipFlag = not skipFlag
			end

			b = Brick((x-1) * 32 + 8 + (13 - numCols) * 16, y * 16)

			if alternatePattern and alternateFlag then
				b.color = alternateColor1
				b.tier = alternateTier1
				alternateFlag = not alternateFlag
			else
				b.color = alternateColor2
				b.tier = alternateTier2
				alternateFlag = not alternateFlag
			end

			if not alternatePattern then
				b.color = solidColor
				b.tier = solidTier
			end

			table.insert(bricks, b)

			--continue here if skipping a block this column
			::continue::
		end
	end

	--if somehow no bricks are made, try again
	if #bricks == 0 then
		return self.createMap(level)
	else
		return bricks
	end
end