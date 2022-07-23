class ListsController < ApplicationController
  before_action :set_list, except: [:top, :index, :create]
  before_action :set_lists, only: [:index]

  def top;  end

  def index
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path
    else
      set_lists
      render :index
    end
    
  end

  def edit; end

  def update
    @list.update(list_params)
    redirect_to lists_path
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end


  private 
  def set_list
    @list = List.find(params[:id])
  end
  def set_lists
    @lists = List.all
  end

  def list_params
    params.require(:list).permit(:title, :body)
  end


end
