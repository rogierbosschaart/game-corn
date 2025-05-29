class UsersController < ApplicationController
  def dashboard
    @user = current_user
    @items = @user.items
    @item = Item.new

    @offers_made = Offer.where(user: @user).order(created_at: :desc)
    @offers_received = Offer.joins(:item).where(items: { user_id: @user.id }).order(created_at: :desc)
  end
end
