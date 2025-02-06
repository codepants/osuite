class AddParentIdToWikiPages < ActiveRecord::Migration[8.0]
  def change
    add_column :wiki_pages, :parent_id, :integer
  end
end
