class User < ActiveRecord::Base
  has_many :pantry_items
  has_many :ingredients
  has_many :recipes

end

# Pantry items can only be initialised by a user
# Recipe, delete items from pantry
