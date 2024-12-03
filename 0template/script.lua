local input = io.open("input.txt", "r")

if input then
	for line in input:lines() do
		print(line)
	end
	input:close()
end
