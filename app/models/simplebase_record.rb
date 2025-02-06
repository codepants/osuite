class SimplebaseRecord < ApplicationRecord
  belongs_to :table, class_name: 'SimplebaseTable', foreign_key: 'simplebase_table_id'
  
  validates :data, presence: true
end 