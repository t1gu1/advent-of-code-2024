local input = io.open("input.txt", "r")
local map = {}
local coordinatesWhereGuardCanBeBlock = {} -- Where all the X are marked after Part 1 Done
local testCoordinatesIteration = 1
local guard = { x = 1, y = 1 }
local guardMovement = { x = 0, y = -1 }

local mapInitial = {}
local guardInitial = { x = 1, y = 1 }
local guardMovementInitial = { x = 0, y = -1 }

local countNbOfTimeGuardCanBeBlock = 0

-- Util to copy table
function Copy(obj, seen)
	if type(obj) ~= "table" then
		return obj
	end
	if seen and seen[obj] then
		return seen[obj]
	end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do
		res[Copy(k, s)] = Copy(v, s)
	end
	return res
end

-- Rules
-- If there is a block #, the guard turn to her right
-- Else the guard continue foward
-- Mark the path visited by a X to calculate the number of unique blocks visited in the end
-- Game stop when guard exit the grid

-- Tool to help debug to see the map progression/discovery
function PrintTheMap(mapToPrint)
	for y = 1, #mapToPrint do
		print(table.concat(mapToPrint[y]))
	end
end

function PrintStartingInfo()
	print("")
	print("Starting position", guard.x, guard.y)
	print(map[guard.y][guard.x])
	print("")
end

function TurnGuardToHerRight(movement)
	-- WHEN GOING UP, TURH TO THE RIGHT
	if movement.x == 0 and movement.y == -1 then
		movement.x = 1
		movement.y = 0
		return
	end

	-- WHEN GOING RIGHT, TURN DOWN
	if movement.x == 1 and movement.y == 0 then
		movement.x = 0
		movement.y = 1
		return
	end

	-- WHEN GOING DOWN, TURN TO THE LEFT
	if movement.x == 0 and movement.y == 1 then
		movement.x = -1
		movement.y = 0
		return
	end

	-- WHEN GOING LEFT, TURN UP
	if movement.x == -1 and movement.y == 0 then
		movement.x = 0
		movement.y = -1
		return
	end
end

function CountAllX()
	local count = 0
	for y = 1, #map do
		for x = 1, #map[y] do
			if map[y][x] == "X" or map[y][x] == "8" then
				count = count + 1
				table.insert(coordinatesWhereGuardCanBeBlock, { x = x, y = y })
			end
		end
	end
	return count
end

function Part1()
	local tes = 1

	while guard.x < #map[1] and guard.y < #map and guard.x > 1 and guard.y > 1 do
		-- Mark the current position as visited
		map[guard.y][guard.x] = "X"

		if map[guard.y + guardMovement.y][guard.x + guardMovement.x] ~= "#" then
			guard.x = guard.x + guardMovement.x
			guard.y = guard.y + guardMovement.y
		else
			TurnGuardToHerRight(guardMovement)
		end

		tes = tes + 1
	end

	map[guard.y][guard.x] = "8"
	PrintTheMap(map)
	print("Total number of X is: " .. CountAllX())
end

-- Reset the map, guard position and guard movement
function Reset()
	map = Copy(mapInitial)
	guard = Copy(guardInitial)
	guardMovement = Copy(guardMovementInitial)
end

function Part2()
	Reset()
	local mapSize = #map[1]

	-- Add an obstacle
	map[coordinatesWhereGuardCanBeBlock[testCoordinatesIteration].y][coordinatesWhereGuardCanBeBlock[testCoordinatesIteration].x] =
		"!"

	local consecutiveTimeRepassOnOldPath = 0
	-- Loop through the mapWhereGuardCanMove to replace all the X one by one with an obstable
	-- Try each iteration to see if the guard can reach the end and is stuck in a loop
	-- Count all the position when the guard is stuck in a loop
	-- Guard is stuck in a loop when she go back to a position she already visited for repeated time of #map + #map[1]
	while
		(guard.x < mapSize and guard.y < #map and guard.x > 1 and guard.y > 1)
		and consecutiveTimeRepassOnOldPath < mapSize * 2
	do
		if map[guard.y][guard.x] == "X" then
			consecutiveTimeRepassOnOldPath = consecutiveTimeRepassOnOldPath + 1
		else
			consecutiveTimeRepassOnOldPath = 0
		end

		-- Mark the current position as visited
		map[guard.y][guard.x] = "X"

		if
			map[guard.y + guardMovement.y][guard.x + guardMovement.x] ~= "#"
			and map[guard.y + guardMovement.y][guard.x + guardMovement.x] ~= "!"
		then
			guard.x = guard.x + guardMovement.x
			guard.y = guard.y + guardMovement.y
		else
			TurnGuardToHerRight(guardMovement)
		end
	end

	map[guard.y][guard.x] = "8"

	if consecutiveTimeRepassOnOldPath >= mapSize * 2 then
		countNbOfTimeGuardCanBeBlock = countNbOfTimeGuardCanBeBlock + 1
	end

	testCoordinatesIteration = testCoordinatesIteration + 1

	if testCoordinatesIteration <= #coordinatesWhereGuardCanBeBlock then
		Part2()
	else
		print("Total number of time guard can be block is: " .. countNbOfTimeGuardCanBeBlock)
	end
end

-- WHERE IT START
if input then
	for line in input:lines() do
		local mapX = {}
		for caracter in line:gmatch(".") do
			table.insert(mapX, caracter)

			-- Set starting position when guard found in the map
			if caracter == "^" then
				guard.x = #mapX
				guard.y = #map + 1
			end
		end

		table.insert(map, mapX)
	end
	input:close()
	mapInitial = Copy(map)
	guardInitial = Copy(guard)

	Part1()
	print("")
	print("--------------------")
	print("Part 2 start HERE")
	Part2() -- Part1 is required to be done before Part2
end
