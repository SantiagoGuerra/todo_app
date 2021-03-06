class TodoItemsController < ApplicationController
  before_action :authorize_user
  before_action :set_todo_list
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy]
  before_action :user_has_persmissions, only: [:create]

  # GET todo_lists/1/todo_items
  def index
    @todo_items = @todo_list.todo_items
  end

  # GET todo_lists/1/todo_items/1
  def show
  end

  # GET todo_lists/1/todo_items/new
  def new
    @todo_item = @todo_list.todo_items.build
  end

  # GET todo_lists/1/todo_items/1/edit
  def edit
  end

  # POST todo_lists/1/todo_items
  def create
    @todo_item = @todo_list.todo_items.build(todo_item_params)

    if @todo_item.save
      redirect_to(@todo_item.todo_list, notice: 'Todo item was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT todo_lists/1/todo_items/1
  def update
    if @todo_item.update(todo_item_params)
      redirect_to(@todo_item.todo_list)
      flash[:success] = 'Todo item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE todo_lists/1/todo_items/1
  def destroy
    @todo_item.destroy

    redirect_to todo_list_todo_items_url(@todo_list)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    def set_todo_item
      @todo_item = @todo_list.todo_items.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def todo_item_params
      params.require(:todo_item).permit(:description, :completed, :todo_list_id)
    end

    def authorize_user 
      if(current_user)
        @user = User.find(current_user.id)
        redirect_to root_url unless current_user == @user
      else
        redirect_to root_url
      end 
    end

    def user_has_persmissions
      todo_list = TodoList.find(params[:todo_list_id]) 
      user = User.find(current_user.id)
      author = todo_list.user
      if(user.id != author.id)
        flash[:danger] = 'You do not have permissions'
        redirect_to todo_lists_url
      end
    end
end
