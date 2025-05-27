class UsersController < ApplicationController
  def dashboard
    @user = current_user
    @items = @user.items

    @offers_made = Offer.where(user: @user)
    @offers_received = Offer.joins(:item).where(items: { user_id: @user.id })
  end
end
