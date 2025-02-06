class Task < ApplicationRecord
  belongs_to :user
  belongs_to :parent_task, class_name: 'Task', optional: true
  has_many :subtasks, class_name: 'Task', foreign_key: 'parent_task_id'
  
  enum :status, {
    pending: 'pending',
    in_progress: 'in_progress',
    completed: 'completed'
  }

  validates :title, presence: true
  validates :status, presence: true
  validates :description, presence: true
  
  before_validation :set_default_status
  
  private
  
  def set_default_status
    self.status ||= :pending
  end
end 