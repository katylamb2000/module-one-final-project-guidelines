
class CreatePantryItem < ActiveRecord::Migration[4.2]
  #define a change method in which to do the migration
  def change
    create_table :pantry_items do |t| #we get a block variable here for the table
      #primary key of :id is created for us!
      # defining columns is as simple as t.[datatype] :column
      t.string :name
      t.integer :quantity
      t.references :user, foreign_key: true
      t.references :ingredient, foreign_key: true
    end
  end
end
