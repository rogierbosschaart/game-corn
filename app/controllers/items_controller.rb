class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:show]

  def index
    @items = Item.all
  end

  def show
    @user = User.find(@item.user_id)
    @markers = [ {
        lat: @item.latitude,
        lng: @item.longitude
      }] if @item.geocoded?
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @user = current_user
    @item.user_id = @user.id
    if @item.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, status: :see_other
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to dashboard_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :genre, :platform, :photo, :address)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def record_not_found
    flash[:alert] = "The game you were looking for could not be found."
    redirect_to items_path
  end
end
