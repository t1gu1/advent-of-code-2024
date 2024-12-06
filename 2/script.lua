local input = io.open("input.txt", "r")

local countIteration = 0
local countSafe = 0

function PrintOnlyFiveFirstLines(toPrint)
	if countIteration < 5 then
		print(toPrint)
	end
end

-- Rules --
-- The levels are either all increasing or all decreasing.
function IsIncreasing(a, b)
	return tonumber(a) < tonumber(b)
end
-- Any two adjacent levels differ by at least one and at most three.
function IsDifferenceIsOneToThreeBetween(a, b)
	return math.abs(a - b) >= 1 and math.abs(a - b) <= 3
end

function Part1(line)
	local isItSafe = true
	local isIncreasing
	local previousLocation

	for location in line:gmatch("%d+") do
		if previousLocation then
			if not IsDifferenceIsOneToThreeBetween(previousLocation, location) then
				isItSafe = false
			end

			if isIncreasing == nil then
				isIncreasing = IsIncreasing(previousLocation, location)
			else
				if IsIncreasing(previousLocation, location) ~= isIncreasing then
					isItSafe = false
				end
			end
		end

		previousLocation = location
	end

	return isItSafe
end

-- PART 2, need to check if it's the first location
function RemoveNumberAtPosition(line, position)
	local isSpaceLastCaracter = false
	local numbersSkipped = 0
	local newLine = ""

	for c in line:gmatch(".") do
		if c == " " and isSpaceLastCaracter == false then
			numbersSkipped = numbersSkipped + 1
		end

		if c == " " then
			isSpaceLastCaracter = true
		else
			isSpaceLastCaracter = false
		end

		if numbersSkipped ~= position - 1 then
			newLine = newLine .. c
		end
	end

	return newLine
end

function Part2(line)
	-- For each number in a line, we test to remove it once to check if there a way when we remove a number, taht is safe

	if Part1(line) then
		return true
	end

	local iteration = 1
	for location in line:gmatch("%d+") do
		local newLine = RemoveNumberAtPosition(line, iteration)
		if Part1(newLine) then
			return true
		end

		iteration = iteration + 1
	end
end

-- WHERE IT START
if input then
	for line in input:lines() do
		if Part2(line) then
			countSafe = countSafe + 1
		else
			-- print("Not Safe: " .. line)
		end

		-- If you want to stop the print after a number of iterations
		countIteration = countIteration + 1
	end
	input:close()

	print("Safe: " .. countSafe)
end
