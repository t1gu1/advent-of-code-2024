local input = io.open("input.txt", "r")
local countIteration = 0
local additionnedMultiplication = 0

function PrintOnlyFiveFirstLines(toPrint)
	if countIteration < 5 then
		print(toPrint)
	end
end

function Part1(line)
	-- print("ITERATION: " .. countIteration)
	-- print(line)

	-- Should only count the mul(X,Y) instructions where X and Y are numbers.
	-- No space or other caracters should be present in the instruction.
	for match in line:gmatch("mul%p%d+,%d+%p") do
		print(match)
		-- PrintOnlyFiveFirstLines(match)

		local multiplyOfTheMatch = 1
		match:gsub("%d+", function(c)
			-- PrintOnlyFiveFirstLines(c)
			multiplyOfTheMatch = multiplyOfTheMatch * c
		end)

		-- PrintOnlyFiveFirstLines("multiplyOfTheMatch: " .. multiplyOfTheMatch)
		additionnedMultiplication = additionnedMultiplication + multiplyOfTheMatch

		-- PrintOnlyFiveFirstLines("additionnedMultiplication: " .. additionnedMultiplication)
		countIteration = countIteration + 1
	end
end

-- function Part2(line) end

-- WHERE IT START
if input then
	for line in input:lines() do
		Part1(line)
		-- Part2(line)

		-- If you want to stop the print after a number of iterations
	end
	input:close()

	print("additionnedMultiplication: " .. additionnedMultiplication)
end

-- Last try = 167714236
