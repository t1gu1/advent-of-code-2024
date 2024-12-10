local input = io.open("input.txt", "r")
local map = {}
local guard = { x = 1, y = 1 }
local guardMovement = { x = 0, y = -1 }

-- Rules
-- If there is a block #, the guard turn to her right
-- Else the guard continue foward
-- Mark the path visited by a X to calculate the number of unique blocks visited in the end
-- Game stop when guard exit the grid

-- Tool to help debug to see the map progression/discovery
function PrintTheMap()
	for y = 1, #map do
		print(table.concat(map[y]))
	end
end

function PrintStartingInfo()
	print("")
	print("Starting position", guard.x, guard.y)
	print(map[guard.y][guard.x])
	print("")
end

function TurnGuardToHerRight()
	print("guard turn")
	-- WHEN GOING UP, TURH TO THE RIGHT
	if guardMovement.x == 0 and guardMovement.y == -1 then
		guardMovement.x = 1
		guardMovement.y = 0
		print("guard face right")
		return
	end

	-- WHEN GOING RIGHT, TURN DOWN
	if guardMovement.x == 1 and guardMovement.y == 0 then
		guardMovement.x = 0
		guardMovement.y = 1
		print("guard face down")
		return
	end

	-- WHEN GOING DOWN, TURN TO THE LEFT
	if guardMovement.x == 0 and guardMovement.y == 1 then
		guardMovement.x = -1
		guardMovement.y = 0
		print("guard face left")
		return
	end

	-- WHEN GOING LEFT, TURN UP
	if guardMovement.x == -1 and guardMovement.y == 0 then
		guardMovement.x = 0
		guardMovement.y = -1
		print("guard face up")
		return
	end
end

function CountAllX()
	local count = 0
	for y = 1, #map do
		for x = 1, #map[y] do
			if map[y][x] == "X" or map[y][x] == "8" then
				count = count + 1
			end
		end
	end
	return count
end

function Part1()
	PrintStartingInfo()

	local iterationToDo = 33

	while guard.x < #map[1] and guard.y < #map and guard.x > 1 and guard.y > 1 do
		-- Mark the current position as visited
		map[guard.y][guard.x] = "X"

		if map[guard.y + guardMovement.y][guard.x + guardMovement.x] ~= "#" then
			print("Move foward")
			guard.x = guard.x + guardMovement.x
			guard.y = guard.y + guardMovement.y
		else
			TurnGuardToHerRight()
		end

		iterationToDo = iterationToDo - 1
	end

	map[guard.y][guard.x] = "8"
	PrintTheMap()
	print("Total number of X is: " .. CountAllX())
end

-- function Part2(line) end

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

	Part1()
end
