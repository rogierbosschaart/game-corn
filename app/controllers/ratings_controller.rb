class RatingsController < ApplicationController

  def new
    @item = Item.find(params[:item_id])
    @rating = Rating.new
  end

  def create
    # @item = Item.find(params[:item_id])
    # @rating = @item.ratings.new(rating_params)
    # @rating.user = current_user

    # if @rating.save
    #   redirect_to @item, notice: "Rating saved"
    # else
    #   redirect_to @item, alert: "Could not save rating"
    # end

    @item = Item.find(params[:item_id])
    existing_rating = @item.ratings.find_by(user: current_user)

    if existing_rating
      redirect_to @item, alert: "You have already rated this item."
      return
    end

    @rating = @item.ratings.build(rating_params)
    @rating.user = current_user

    if @rating.save
      redirect_to @item, notice: "Rating saved"
    else
      redirect_to @item, alert: "Could not save rating: #{@rating.errors.full_messages.join(', ')}"
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value, :comment)
  end
end
