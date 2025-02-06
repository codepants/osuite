class SimplebaseTable < ApplicationRecord
  has_many :records, class_name: 'SimplebaseRecord'
  
  validates :name, presence: true, uniqueness: true
  validates :schema, presence: true
end 