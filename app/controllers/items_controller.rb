class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @items = Item.all
  end

  def show
    @user = User.find(@item.user_id)

    # @markers = @user.geocoded.map do |user|
    #   {
    #     lat: user.latitude,
    #     lng: user.longitude
    #   }
    # end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @user = current_user
    @item.user_id = @user.id
    if @item.save
      redirect_to dashboard_path, notice: 'Game was successfully added to your listings!'
    else
      redirect_to dashboard_path, alert: @item.errors.full_messages.to_sentence
      #render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to dashboard_path, status: :see_other, notice: 'Game was successfully removed from your listings.'
    #redirect_to items_path, status: :see_other
  end

  def edit
  end

  def update
    if @item.update(item_params)
      #redirect_to dashboard_path
      redirect_to dashboard_path, notice: 'Game details were successfully updated!'
    else
      flash.now[:alert] = "There was a problem updating game details."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :genre, :platform, :photo, :description)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def record_not_found
    flash[:alert] = "The game you were looking for could not be found."
    redirect_to items_path
  end
end
