local root = script.Parent
local lev = require(root.Lev)

local tests = {
	{ { "saturday", "sunday" }, 3 },
	{ { "some", "something" }, 5 },
	{ { "tea", "" }, 3 },
}

for _, test in ipairs(tests) do
	local expected = test[2]
	local actual = lev(table.unpack(test[1]))

	if expected ~= actual then
		error(string.format("Expected %d, got %d", expected, actual))
	end
end
