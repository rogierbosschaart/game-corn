class OffersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:new, :create]
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
    @offer = @item.offers.new(offer_params)
    @offer.user = current_user

    if @offer.save
      redirect_to item_path(@item), notice: 'Your offer request has been sent!'
    else
      flash.now[:alert] = "There was a problem creating your offer. Please check the form."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    offer = Offer.find(params[:id])
    offer.update(accepted: params[:accepted])
    redirect_to dashboard_path
  end

    def destroy
      @offer = Offer.find(params[:id])
      @offer.destroy
      redirect_to dashboard_path, notice: 'Offer was successfully destroyed.'
    end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

    # def set_offer
    #     @offer = Offer.find(params[:id])
    # end

  def offer_params
    params.require(:offer).permit(:comment, :start_date, :end_date)
  end
end
