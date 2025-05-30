class RatingsController < ApplicationController

  def new
    @item = Item.find(params[:item_id])
    @rating = Rating.new
  end

  def create
    @item = Item.find(params[:item_id])
    @rating = @item.ratings.new(rating_params)
    @rating.user = current_user

    if @rating.save
      redirect_to @item, notice: "Rating saved"
    else
      redirect_to @item, alert: "Could not save rating"
    end
  end

  def update
    @rating = current_user.ratings.find(params[:id])
    @item = @rating.item

    if @rating.update(rating_params)
      redirect_to @item, notice: 'Thanks for updating your rating'
    else
      redirect_to @item, alert: "Error"
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end
