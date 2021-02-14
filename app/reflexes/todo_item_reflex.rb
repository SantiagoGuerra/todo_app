# frozen_string_literal: true

class TodoItemReflex < ApplicationReflex
  def mark_incompleted
    todo_item = TodoItem.find(element.dataset.id)
    todo_item.update(completed: false)
  end

  def mark_completed
    todo_item = TodoItem.find(element.dataset.id)
    todo_item.update(completed: true)
  end
end
