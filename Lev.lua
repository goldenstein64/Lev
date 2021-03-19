--[[
function LevenshteinDistance(char s[1..m], char t[1..n]):
	-- for all i and j, d[i,j] will hold the Levenshtein distance between
	-- the first i characters of s and the first j characters of t
	declare int d[0..m+1, 0..n+1]

	set each element in d to zero

	-- source prefixes can be transformed into empty string by
	-- dropping all characters
	for i from 1 to m + 1:
		d[i, 0] := i
 
	-- target prefixes can be reached from empty source prefix
	-- by inserting every character
	for j from 1 to n + 1:
		d[0, j] := j

	for j from 1 to n + 1:
		for i from 1 to m + 1:
			if s[i - 1] = t[j - 1]:
				substitutionCost := 0
			else:
				substitutionCost := 1

			d[i, j] := minimum(d[i-1, j] + 1,                   -- deletion
												 d[i, j-1] + 1,                   -- insertion
												 d[i-1, j-1] + substitutionCost)  -- substitution
 
	return d[m, n]
--]]

local len = string.len
local lower = string.lower
local sub = string.sub

local function LevenshteinDistance(str1, str2)
	str1 = lower(str1)
	str2 = lower(str2)
	local len1 = len(str1)
	local len2 = len(str2)

	local array = {}
	for i = 0, len1 do
		array[i] = { [0] = i }
	end
	for j = 1, len2 do
		array[0][j] = j
	end

	for i = 1, len1 do
		for j = 1, len2 do
			local cost = sub(str1, i, i) == sub(str2, j, j) and 0 or 1

			array[i][j] = math.min(array[i - 1][j] + 1, array[i][j - 1] + 1, array[i - 1][j - 1] + cost)
		end
	end

	return array[len1][len2]
end

return LevenshteinDistance
