require 'rest-client'
require 'json'
require 'pry'

def get_recipes_from_api(main_ingredient)
  #make the web request
  response_string = RestClient.get('https://www.themealdb.com/api/json/v1/1/random.php')
  meal_data = JSON.parse(response_string)
  extract_ingredients(meal_data, main_ingredient)
end
#   # iterate over the response hash to find the collection of `recipes` for the given
#   #   `ingredient`
#   # collect those recipe API urls, make a web request to each URL to get the info
#   #  for that recipe
#   # return value of this method should be collection of info about each recipe.
#   #  i.e. an array of hashes in which each hash reps a given recipe
#
#   # hash with key 'meals', which contains an array of hashes. Each hash is one recipe. The hash contains key-value pairs.


def extract_ingredients(meal_data, main_ingredient)
    # if COUNTER < 100
    # result = []
      meal_data["meals"].each do |meal|
          for i in 1..20 do
            if meal["strIngredient#{i}"]
              if meal["strIngredient#{i}"].downcase == main_ingredient.downcase
                puts meal
              end
            else
              get_recipes_from_api(main_ingredient)
              puts meal
            end
          end
    #       if result.length == 0
    #         get_recipes_from_api(main_ingredient)
    #       end
    #       # COUNTER += 1
    # # else
    # #   p "Sorry, can't find #{main_ingredient}"
    # end
    # p result
end
end

# def find_meal(main_ingredient)
#   get_recipes_from_api(main_ingredient)
# end
# binding.pry

main_ingredient = "salt"
# find_meal(main_ingredient)


#
# def print_movies(films_hash)
#   # some iteration magic and puts out the movies in a nice list
#
#   p "#{films_hash["title"]}"
# end
#
#
# def show_character_movies(character)
#   films_array = get_character_movies_from_api(character)
#   #print_movies(films_array)
# end
