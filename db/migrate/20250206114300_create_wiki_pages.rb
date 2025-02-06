class CreateWikiPages < ActiveRecord::Migration[8.0]
  def change
    create_table :wiki_pages do |t|
      t.string :title
      t.string :slug
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
    
    add_index :wiki_pages, :slug, unique: true
  end
end 