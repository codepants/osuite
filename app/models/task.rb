class Task < ApplicationRecord
  belongs_to :user
  belongs_to :parent_task, class_name: 'Task', optional: true
  has_many :subtasks, class_name: 'Task', foreign_key: 'parent_task_id'
  has_rich_text :content
  
  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in_progress completed] }
end 