class Note < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  
  validates :title, presence: true
end 