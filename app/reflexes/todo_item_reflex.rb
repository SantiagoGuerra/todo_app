# frozen_string_literal: true

class TodoItemReflex < ApplicationReflex
  def mark_incompleted
    current_user = element.dataset.current_user
    todo_item = TodoItem.find(element.dataset.id)
    author = todo_item.todo_list.user
    user = User.find(current_user)
    if(user.id != author.id)
      flash[:danger] = 'You do not have permissions'
    else
      todo_item.update(completed: false)
    end
  end

  def mark_completed
    todo_item = TodoItem.find(element.dataset.id)
    todo_item.update(completed: true)
  end

  def delete
    todo_item = TodoItem.find(element.dataset.id)
    todo_item.destroy
  end
end
