ingredients_array = %w(mushroom onion chicken beef tomato noodle ketchup)


puts "Starting seed"
ingredients_array.each do |ing|
 ingredient = Ingredient.create(name: ing)
 p ingredient.name
end
puts "Seed finishing"
