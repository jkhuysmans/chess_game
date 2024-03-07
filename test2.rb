strings = ["apple", "banana", "apple", "orange", "banana"]

# Check if any string is repeated 3 times
if strings.any? { |string| strings.count(string) == 3 }
  puts "At least one string is repeated 3 times."
else
  puts "No string is repeated 3 times."
end