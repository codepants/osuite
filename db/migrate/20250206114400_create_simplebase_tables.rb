class CreateSimplebaseTables < ActiveRecord::Migration[8.0]
  def change
    create_table :simplebase_tables do |t|
      t.string :name
      t.json :schema
      
      t.timestamps
    end
    
    create_table :simplebase_records do |t|
      t.references :simplebase_table, null: false, foreign_key: true
      t.json :data
      
      t.timestamps
    end
  end
end 