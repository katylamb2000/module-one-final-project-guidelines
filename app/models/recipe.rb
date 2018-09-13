class Recipe < ActiveRecord::Base
  has_many :pantry_items #through :ingredients
  has_many :ingredients
  belongs_to :user
end
