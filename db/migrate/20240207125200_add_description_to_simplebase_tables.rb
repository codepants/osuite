class AddDescriptionToSimplebaseTables < ActiveRecord::Migration[7.1]
  def change
    add_column :simplebase_tables, :description, :text
  end
end 