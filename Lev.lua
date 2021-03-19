--[[ Source: https://en.wikipedia.org/wiki/Levenshtein_distance#Iterative_with_full_matrix
function LevenshteinDistance(char s[1..m], char t[1..n]):
	// for all i and j, d[i,j] will hold the Levenshtein distance between
	// the first i characters of s and the first j characters of t
	declare int d[0..m, 0..n]

	set each element in d to zero

	// source prefixes can be transformed into empty string by
	// dropping all characters
	for i from 1 to m:
		d[i, 0] := i

	// target prefixes can be reached from empty source prefix
	// by inserting every character
	for j from 1 to n:
		d[0, j] := j

	for j from 1 to n:
		for i from 1 to m:
			if s[i] = t[j]:
				substitutionCost := 0
			else:
				substitutionCost := 1

			d[i, j] := minimum(d[i-1, j] + 1,						// deletion
							   d[i, j-1] + 1,						// insertion
							   d[i-1, j-1] + substitutionCost)		// substitution

	return d[m, n]
--]]

local len = string.len
local lower = string.lower
local sub = string.sub

local function LevenshteinDistance(str1, str2)
	str1, str2 = lower(str1), lower(str2)
	local len1, len2 = len(str1), len(str2)

	local matrix = {}
	for i = 0, len1 do
		matrix[i] = { [0] = i }
	end
	for j = 1, len2 do
		matrix[0][j] = j
	end

	for i = 1, len1 do
		for j = 1, len2 do
			local cost = sub(str1, i, i) == sub(str2, j, j) and 0 or 1

			matrix[i][j] = math.min(
				matrix[i - 1][j] + 1,
				matrix[i][j - 1] + 1,
				matrix[i - 1][j - 1] + cost
			)
		end
	end

	return matrix[len1][len2]
end

return LevenshteinDistance
