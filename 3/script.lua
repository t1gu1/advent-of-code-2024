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

-- Clean up the input by removing what's between every "don't()" and a "do()"
-- Clean up the input by removing what's after a "don't()" at the end if no do() follow
function Part2(text)
	local cleanInput = text
	cleanInput = cleanInput:gsub("don't%(%).-do%(%)", "")
	cleanInput = cleanInput:gsub("don't%(%).*", "")
	print(cleanInput)
	return Part1(cleanInput)
end

-- WHERE IT START
if input then
	local accLines = ""
	for line in input:lines() do
		accLines = accLines .. line
	end
	input:close()

	print("additionnedMultiplication part 1: " .. Part1(accLines))
	print("additionnedMultiplication part 2: " .. Part2(accLines))
end
