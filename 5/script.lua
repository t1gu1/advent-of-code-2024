local input = io.open("input.txt", "r")

local pagesRules = {}
local updatesTable = {}
local failUpdatesTable = {}
local part1ResponseAcc = 0
local part2ResponseAcc = 0

function CreatePageTable(line)
	local left, right = line:match("(%d+)|(%d+)")

	if left ~= nil and right ~= nil then
		table.insert(pagesRules, { left = left, right = right })
		return true
	else
		return false
	end
end

function CreateUpdatesTable(line)
	if line ~= "" then
		table.insert(updatesTable, line)
	end
end

function FindMiddleNumber(tableToCheck)
	local updateTable = {}
	for n in tableToCheck:gmatch("%d+") do
		table.insert(updateTable, n)
	end

	return updateTable[math.ceil(#updateTable / 2)]
end

function Part1()
	for _, update in pairs(updatesTable) do
		local isUpdatePass = true

		for _, page in pairs(pagesRules) do
			local leftPagePositionInUpdate = update:find(page.left)
			local rightPagePositionInUpdate = update:find(page.right)

			if
				leftPagePositionInUpdate ~= nil
				and rightPagePositionInUpdate ~= nil
				and leftPagePositionInUpdate > rightPagePositionInUpdate
			then
				isUpdatePass = false
				break
			end
		end

		-- Calculate the middle number
		if isUpdatePass then
			part1ResponseAcc = part1ResponseAcc + FindMiddleNumber(update)
		else
			table.insert(failUpdatesTable, update)
		end
	end

	print("Part 1 response: " .. part1ResponseAcc)
end

function SwitchNumber(update, valA, valB)
	local a1, a2 = update:find(valA)
	local b1, b2 = update:find(valB)
	local firstEdit = update:sub(1, a1 - 1) .. valB .. update:sub(a2 + 1, -1)
	return firstEdit:sub(1, b1 - 1) .. valA .. firstEdit:sub(b2 + 1, -1)
end

function Part2(updatesTableToRun)
	local nextFailedTableToRun = {}
	for _, update in pairs(updatesTableToRun) do
		local isUpdatePass = true

		for _, page in pairs(pagesRules) do
			local leftPagePositionInUpdate = update:find(page.left)
			local rightPagePositionInUpdate = update:find(page.right)

			if
				leftPagePositionInUpdate ~= nil
				and rightPagePositionInUpdate ~= nil
				and leftPagePositionInUpdate > rightPagePositionInUpdate
			then
				isUpdatePass = false
				table.insert(nextFailedTableToRun, SwitchNumber(update, page.left, page.right))
				break
			end
		end

		if isUpdatePass then
			part2ResponseAcc = part2ResponseAcc + FindMiddleNumber(update)
		end
	end

	if #nextFailedTableToRun ~= 0 then
		Part2(nextFailedTableToRun)
	else
		print("Part 2 response: " .. part2ResponseAcc)
	end
end

-- WHERE IT START
if input then
	for line in input:lines() do
		if not CreatePageTable(line) then
			CreateUpdatesTable(line)
		end
	end
	input:close()

	Part1()
	Part2(failUpdatesTable)
end
