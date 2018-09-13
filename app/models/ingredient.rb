class Ingredient < ActiveRecord::Base
  belongs_to :recipes
  belongs_to :pantry_item
end
