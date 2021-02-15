class PagesController < ApplicationController
  def home
  end

  def search
    if params[:search].blank?  
      redirect_to(root_path)
      flash[:warning] = 'Empty field'      
    else
      @parameter = params[:search].downcase  
      @total = TodoItem.all.where("lower(description) LIKE :search", search: "%#{@parameter}%")
      @pagy, @results = pagy(TodoItem.all.where("lower(description) LIKE :search", search: "%#{@parameter}%"))  
    end  
  end
end
