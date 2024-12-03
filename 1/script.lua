local input = io.open("input.txt", "r")

local arrayLeft = {}
local arrayRight = {}
local total = 0

function ReadLinesAndSplitInTwoTable(a)
	for line in a:lines() do
		local left = line:sub(0, 5)
		local right = line:sub(9, 13)

		table.insert(arrayLeft, left)
		table.insert(arrayRight, right)
	end
end

function SortTables()
	table.sort(arrayLeft)
	table.sort(arrayRight)
end

function CalcTheDiff()
	for k, v in ipairs(arrayLeft) do
		-- print(k, v, arrayRight[k])
		-- print(math.abs(v - arrayRight[k]))
		total = total + math.abs(v - arrayRight[k])
	end

	print(total)
end

-- WHERE IT START
if input then
	ReadLinesAndSplitInTwoTable(input)
	input:close()
	SortTables()
	CalcTheDiff()
end
