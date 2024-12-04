local input = io.open("input.txt", "r")
local countIteration = 0

function PrintOnlyFiveFirstLines(toPrint)
	if countIteration < 5 then
		print(toPrint)
	end
end

function Part1(line)
	print(line)
end

-- function Part2(line) end

-- WHERE IT START
if input then
	for line in input:lines() do
		Part1(line)
		-- Part2(line)

		-- If you want to stop the print after a number of iterations
		countIteration = countIteration + 1
	end
	input:close()
end
