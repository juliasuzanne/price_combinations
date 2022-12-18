# NEED TO UPDATE SO THAT IF TWO ITEMS HAVE THE SAME PRICE IT WILL READ "OR"

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

# new array that saves all possible combinations of prices from previous prices only array
combinations = []
i = 0
while i < prices_only.length
  combinations << prices_only.combination(prices_only.length - i).to_a
  i += 1
end

# reduce nesting of arrays into one array with all possible combinations regardless of number of prices combined
combinations = combinations.flatten(1)

# save sum of each possible combination
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

# save index of sums that match the target sum to a new array, so we can cross reference with the saved values that added up to match the target price
sums_index = []
index = 0
while index < combination_sums.length
  if combination_sums[index] == target_price
    sums_index << index
  end
  index += 1
end

# use the sums_index array to access and then save the working combinations only
working_combinations = []
sums_index.each do |index|
  working_combinations << combinations[index]
end

#convert prices to a hash with float values as prices
prices = prices.to_h
prices = Hash[prices.map { |k, v| [k, v.to_f] }]

# convert each item in the working combination array to the name of the dish rather than the price using the key method
i = 0
j = 0
while i < working_combinations.length
  while j < working_combinations[i].length
    working_combinations[i][j] = prices.key(working_combinations[i][j])
    j += 1
  end
  j = 0
  i += 1
end

# check if there were any solutions, if not print There are no possible solutions, if there are interpolate every possible solution. Need to figure out how to add an "OR" in case there are multiple dishes with the same price.
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
