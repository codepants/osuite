class ChatMessage < ApplicationRecord
  belongs_to :user
  broadcasts_to ->(message) { "chat_room" }
  
  validates :content, presence: true
end 