class Task < ApplicationRecord
  enum status: { todo: 0, doing: 1, done: 2 }

  # Fuzzy search for both title and description (case-insensitive)
  ransacker :title_or_description_cont do |parent|
    Arel::Nodes::NamedFunction.new(
      'concat',
      [
        Arel::Nodes::NamedFunction.new('coalesce', [parent.table[:title], Arel.sql("''")]),
        Arel.sql("' '"),
        Arel::Nodes::NamedFunction.new('coalesce', [parent.table[:description], Arel.sql("''")])
      ]
    )
  end

  validates :title, presence: true
  validates :status, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ['title', 'description', 'status', 'deadline', 'priority', 'created_at', 'updated_at', 'title_or_description_cont']
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end