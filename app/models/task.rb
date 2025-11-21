class Task < ApplicationRecord
  enum status: { todo: 0, doing: 1, done: 2 }
  
  # Add custom ransacker for searching both title and description
  ransacker :title_or_description do
    Arel.sql("LOWER(CONCAT(COALESCE(title, ''), ' ', COALESCE(description, '')))")
  end
  
  validates :title, presence: true
  validates :status, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ['title', 'description', 'status', 'deadline', 'priority', 'created_at', 'updated_at']
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
  
end
