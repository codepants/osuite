class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :status, default: 'pending'
      t.references :user, null: false, foreign_key: true
      t.references :parent_task, null: true, foreign_key: { to_table: :tasks }
      
      t.timestamps
    end
  end
end 