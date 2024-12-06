local input = io.open("input.txt", "r")
local countIteration = 0
local additionnedMultiplication = 0

function PrintOnlyFiveFirstLines(toPrint)
	if countIteration < 5 then
		print(toPrint)
	end
end

function Part1(line)
	-- Should only count the mul(X,Y) instructions where X and Y are numbers.
	-- No space or other caracters should be present in the instruction.
	for a, b in line:gmatch("mul%((%d+),(%d+)%)") do
		additionnedMultiplication = additionnedMultiplication + a * b
		countIteration = countIteration + 1
	end
end

-- WHERE IT START
if input then
	for line in input:lines() do
		Part1(line)
	end
	input:close()

	print("additionnedMultiplication: " .. additionnedMultiplication)
end
