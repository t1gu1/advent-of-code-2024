local input = io.open("input.txt", "r")
local inputTable = {}
local countXMAS = 0

function AddXMAS(n)
	n = n or 1
	countXMAS = countXMAS + n
end

function CheckHorizontalWord(hTable)
	local word = table.concat(hTable)
	if word == "XMAS" or word == "SAMX" then
		AddXMAS()
	end
end

function CheckVerticalWord(a, b, c, d)
	for i = 1, 4 do
		local word = a[i] .. b[i] .. c[i] .. d[i]
		if word == "XMAS" or word == "SAMX" then
			AddXMAS()
		end
	end
end

function CheckDiagonalWord(a, b, c, d)
	local diagonalA = a[1] .. b[2] .. c[3] .. d[4]
	local diagonalB = a[4] .. b[3] .. c[2] .. d[1]
	if diagonalA == "XMAS" or diagonalA == "SAMX" then
		AddXMAS()
	end
	if diagonalB == "XMAS" or diagonalB == "SAMX" then
		AddXMAS()
	end
end

-- Find every the XMAS words
-- It can be horizontal, vertical, diagonal, written backwards, or even overlapping other words
-- Each 4 iteration check horizontal possibilities (4row at the same time)
-- Every iteration check vertical and diagonal possibilities
function Part1()
	-- Vertical
	for vi = 1, #inputTable - 3 do
		local lastFourC1 = {}
		local lastFourC2 = {}
		local lastFourC3 = {}
		local lastFourC4 = {}

		-- Horizontal
		for i = 1, #inputTable[vi] do
			-- Check 4 vertical row at the same time
			local c1 = inputTable[vi]:sub(i, i)
			local c2 = inputTable[vi + 1]:sub(i, i)
			local c3 = inputTable[vi + 2]:sub(i, i)
			local c4 = inputTable[vi + 3]:sub(i, i)

			table.insert(lastFourC1, c1)
			table.insert(lastFourC2, c2)
			table.insert(lastFourC3, c3)
			table.insert(lastFourC4, c4)

			if i > 4 then
				table.remove(lastFourC1, 1)
				table.remove(lastFourC2, 1)
				table.remove(lastFourC3, 1)
				table.remove(lastFourC4, 1)
			end

			if i >= 4 then
				if vi == 1 then
					CheckHorizontalWord(lastFourC1)
					CheckHorizontalWord(lastFourC2)
					CheckHorizontalWord(lastFourC3)
					CheckHorizontalWord(lastFourC4)
				else
					CheckHorizontalWord(lastFourC4)
				end

				-- Check vertical every 4 iteration
				if i % 4 == 0 then
					CheckVerticalWord(lastFourC1, lastFourC2, lastFourC3, lastFourC4)
				end

				CheckDiagonalWord(lastFourC1, lastFourC2, lastFourC3, lastFourC4)
			end
		end
	end

	print(countXMAS)
end

-- WHERE IT START
if input then
	for line in input:lines() do
		table.insert(inputTable, line)
	end
	input:close()

	Part1()
end
