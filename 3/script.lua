local input = io.open("input.txt", "r")

-- Should only count the mul(X,Y) instructions where X and Y are numbers.
-- No space or other caracters should be present in the instruction.
function Part1(line)
	local additionnedMultiplication = 0
	for a, b in line:gmatch("mul%((%d+),(%d+)%)") do
		additionnedMultiplication = additionnedMultiplication + a * b
	end
	return additionnedMultiplication
end

function Part2(line) end

-- WHERE IT START
if input then
	local accLines = ""
	for line in input:lines() do
		accLines = accLines .. line
	end
	input:close()

	print("additionnedMultiplication: " .. Part1(accLines))
end
