class TodoItem < ApplicationRecord
  validates :description, length: { minimum: 5, message: 'too short' }

  belongs_to :todo_list

  scope :completed, -> do
    where(completed: true)
  end
end
