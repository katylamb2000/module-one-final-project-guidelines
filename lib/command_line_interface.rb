require 'rest-client'
require 'json'
require 'pry'
# require 'highline'

# class ApiCommunicator
#
#   attr_accessor :page_url

def welcome
  puts "Welcome to the random recipe generator!"
  puts "This program will find a recipe for you from our database, based on the ingredient you have in your cupboard!"
  puts "You can save your favourite recipes to your own personal recipe book!"
end

def create_new_user
  puts "What is your name?"
  User.create(name: gets.chomp)
end

def get_ingredients_from_user
  puts "Please enter an ingredient"
  gets.chomp.downcase
end

# def add_pantry_item
#   puts "Please enter an item you have in your pantry"
#   gets.chomp #new pantry_item
# end

def user_commands
  puts "1. See a list of available ingredients"
  puts "2. See a list of your items"
  puts "3. Add a new ingredient to your pantry"
  puts "4. Get new recipe from my ingredients"
  puts "5. List your recipes"
  puts "6. Remove an item from your pantry"
  # puts "add item - "
  # puts "cook - save recipe to your recipe book and remove items from pantry"
  #  saves the recipe
end

def add_ingredient_from_list
  puts "Add ingredient from list to your pantry?(y or n)"
  gets.chomp
end


def search_recipes(ingredients)
  string = ingredients.join(",")
  url = "http://www.recipepuppy.com/api/?i=#{string}"
  response = RestClient.get(url)
  data = JSON.parse(response)
  puts "With your ingredients, you can make;"
   data["results"][0..5].each.with_index do |recipe, i|
     puts "#{i+1}. #{recipe["title"].strip}"
   end
   puts "---------------------------------"
   puts "Which recipe would you like to add? i.e.(1)"
   number_item = gets.chomp.to_i
   data["results"].each.with_index do |recipe, i|
       Recipe.create(title: recipe["title"].strip, link: recipe["href"], ingredients: "test", user: @user)
if number_item - 1 == i
     end
   end
p Recipe.last.title
puts "----------------------------------"
   run_app
end

def extract_ingredients(found_recipe)
  new_array = []
  found_recipe.each do |k, v|
    k[:ingredients].split(", ").each do |ingredient|
      new_array << ingredient
    end
  end
  new_array
end

def run_app
  user_commands
  answer = gets.chomp.downcase
  system('clear')
  case answer
    when "1"
      puts "----------------------------------"
        Ingredient.all.each.with_index do |ing, i|
          puts "#{i+1}. #{ing.name}"
        end
        puts "----------------------------------"
        case add_ingredient_from_list
          when "y"
            puts "----------------------------------"
            puts "Choose an ingredient. i.e. (1)"
            ans = gets.chomp
            Ingredient.all.each.with_index do |ing, i|
              if ans.to_i - 1 == i
                 pa = PantryItem.create(name: ing.name, user: @user, ingredient: ing, quantity: 1)
                 puts "----------------------------------"
                puts pa.name
                puts "----------------------------------"
                run_app
              end
            end
          when "n"
            system('clear')
            run_app
        end
    when "2"
      # binding.pry
      puts "----------------------------------"
      puts "You have these ingredients"
      # binding.pry
      @user.pantry_items.each.with_index do |ing, i|
      puts "#{i+1}. #{ing.name}"
      run_app
      end
        # binding.pry
      # list_pantry_items
    when "3"
      puts "----------------------------------"
      puts "Add an ingredient to your pantry"

      new_pantry_item = gets.chomp.downcase
      PantryItem.create(name: new_pantry_item, user: @user)
       # ingredient: new_pantry_item, quantity: 1)
      puts "You have added #{new_pantry_item} to your pantry"
      run_app



    when "4"
      puts "Searching for recipes..... Stand by!!"
      new_pa_array = @user.pantry_items.map do |pa|
        pa.name
      end
      search_recipes(new_pa_array)
    when "5"
      list_recipes
        puts "View recipe in your browser?(y or n)"
        response = gets.chomp
        if response == "y"
          open_recipe_website
        end
    when "6"
      puts "----------------------------------"
      puts "Would you like to remove an item?"
        puts "Please select which item you would like to remove, e.g. 1"
          ans = gets.chomp.to_i
          # binding.pry
          puts "Deleting item..."
          @user.pantry_items[ans[-1]].destroy
          # binding.pry
      run_app
      end
    end


def list_recipes
  @user.recipes.each_with_index do |recipe, i|
    puts "#{i+1}. #{recipe.title}"
end

def open_recipe_website
  puts "Please select which recipe you would like to view, e.g. 1"
  response = gets.chomp.to_i
  # binding.pry
  # recipe_url = @user.recipes[responseb[-1]].link
  recipe_url = @user.recipes[response[-1]].link
  `open "#{recipe_url}"`
end

def add_pantry_item
  new_pantry_item = gets.chomp.downcase
  PantryItem.create(name: new_pantry_item, user: @user)
   # ingredient: new_pantry_item, quantity: 1)
  puts "You have added #{new_pantry_item} to your pantry"
end

def list_pantry_items
  puts "You have these ingredients"
  binding.pry
  @user.pantry_items.each.with_index do |ing, i|
  puts "#{i+1}. #{ing.name}"
  end
end

def remove_pantry_item
  puts "----------------------------------"
  puts "Would you like to remove an item?"
    puts "Please select which recipe you would like to remove, e.g. 1"
      ans = gets.chomp.to_i
      puts "Deleting item..."
      @user.recipes[ans[-1]].destroy
    end



end
