class AddDueDateToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :due_date, :datetime
    add_index :tasks, :due_date
  end
end 