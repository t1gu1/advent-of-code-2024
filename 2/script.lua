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
	return a < b
end
-- Any two adjacent levels differ by at least one and at most three.
function IsDifferenceIsOneToThreeBetween(a, b)
	return math.abs(a - b) >= 1 and math.abs(a - b) <= 3
end

function Part1(line)
	PrintOnlyFiveFirstLines(line)

	local isItSafe = true
	local isIncreasing
	local previousLocation

	for location in line:gmatch("%d+") do
		if previousLocation then
			if not IsDifferenceIsOneToThreeBetween(previousLocation, location) then
				isItSafe = false
				-- PrintOnlyFiveFirstLines(
				-- 	"DifferenceIsNotOneToThreeBetween,  Previous: " .. previousLocation .. "  Now: " .. location
				-- )
			end

			if isIncreasing == nil then
				-- PrintOnlyFiveFirstLines("IsIncreasingInfo")
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

-- function Part2(line) end

-- WHERE IT START
if input then
	for line in input:lines() do
		if Part1(line) then
			countSafe = countSafe + 1
		end

		-- If you want to stop the print after a number of iterations
		countIteration = countIteration + 1
	end
	input:close()

	print("Safe: " .. countSafe)
end
