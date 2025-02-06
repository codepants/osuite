class WikiPage < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  belongs_to :parent, class_name: 'WikiPage', optional: true
  has_many :children, class_name: 'WikiPage', foreign_key: 'parent_id'
  
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  
  before_validation :generate_slug
  
  private
  
  def generate_slug
    self.slug = title.parameterize if title_changed?
  end
end 