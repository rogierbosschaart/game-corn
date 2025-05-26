class OffersController < ApplicationController
  belongs_to :item
  # before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # def home
  #   @offers = Offer.all
  # end

  # def show
  #   @offer = Offer.find(params[:id])
  # end

  def new
    @item = Item.find(params[:item_id])
    @offer = Offer.new
    @offer.item = @item
  end

  def create
    @item = Item.find(params[:item_id])
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    @offer.item = @item
    if @offer.save
      redirect_to root, notice: 'Offer was successfully created.'
    else
      render :new, alert: "There was a problem creating your offer."
    end
  end

    # def edit
    # end

    # def update
    #     if @offer.update(offer_params)
    #     redirect_to @offer, notice: 'Offer was successfully updated.'
    #     else
    #     render :edit
    #     end
    # end

    # def destroy
    #     @offer.destroy
    #     redirect_to offers_url, notice: 'Offer was successfully destroyed.'
    # end

  private

    # def set_offer
    #     @offer = Offer.find(params[:id])
    # end

  def offer_params
    params.require(:offer).permit(:comment)
  end
end
