require "csv"

prices = CSV.read("prices.csv")

#verify csv is being read
# p prices

# save the target price in a variable
target_price = prices[0][1].to_f

# remove target price from prices to prep data
prices.delete_at(0)

# verify target price was saved correctly
# p target_price

# new array that saves all prices as floats
prices_only = []

prices.each do |item|
  prices_only << item[1].to_f
end

# verify loop did what expected
# p prices_only

# combination = prices_only.combination(2).to_a
# combination = prices_only.combination(prices_only.length).to_a

# p combination

combinations = []
i = 0

while i < prices_only.length
  combinations << prices_only.combination(prices_only.length - i).to_a
  i += 1
end

combinations = combinations.flatten(1)

# p "COMBINATIONS"
# pp combinations
sum = 0
i = 0

combination_sums = []

while i < combinations.length
  combinations[i].each do |number|
    sum = sum + number
  end
  combination_sums[i] = sum.round(2)
  sum = 0
  i += 1
end

# p "SUMS"
# pp combination_sums

# go through each array within array and turn them into sums
# while i < combinations.length
#   while j < combinations[i].length
#     combinations[i][j].each do |number|

#     j += 1
#     sum = 0
#   end
#   i += 1
# end

sums_index = []
index = 0

while index < combination_sums.length
  if combination_sums[index] == target_price
    sums_index << index
  end
  index += 1
end

# pp sums_index

working_combinations = []
sums_index.each do |index|
  working_combinations << combinations[index]
end

# pp working_combinations

prices = prices.to_h
prices = Hash[prices.map { |k, v| [k, v.to_f] }]

# pp prices

#p prices.key("2.75")

new_array = []
i = 0
j = 0

# pp working_combinations
while i < working_combinations.length
  while j < working_combinations[i].length
    working_combinations[i][j] = prices.key(working_combinations[i][j])
    j += 1
  end
  j = 0
  i += 1
end
# p "WORKING COMBOS"
# p working_combinations

if working_combinations.length == 0
  p "There are no possible solutions"
else
  i = 0
  p "Number of possible solutions: #{working_combinations.length}"
  while i < working_combinations.length
    p "Solution #{i + 1} includes: #{working_combinations[i].join(", ")}"
    i += 1
  end
end
