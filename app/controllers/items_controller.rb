class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_restaurant, only: [:show]

  def index
    @items = Item.all.includes(:user)
  end

  def show
  end

  private

  def set_restaurant
    @item = Item.find(params[:id])
  end
end
