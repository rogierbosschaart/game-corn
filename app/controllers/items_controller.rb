class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index

    @items = Item.all.order(created_at: :desc)
    @rating = Rating.new
    if params[:query].present?
      @items = Item.search_by_params(params[:query]).order(created_at: :desc)
    end
  end

  def show
    @user = User.find(@item.user_id)
    @rating = Rating.new
    @actual_rating = Rating.find_by(user: @user, item: @item)
    @rating_value = @actual_rating&.value
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
    respond_to do |format|
      format.html # edit.html.erb
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("edit_item_form_#{@item.id}", partial: "items/form", locals: { item: @item })
      end
    end
  end

  def update
    if @item.update(item_params)
      #redirect_to dashboard_path
      redirect_to dashboard_path, notice: 'Game details were successfully updated!'
    else
      respond_to do |format|
        format.html { flash.now[:alert] = "There was a problem updating game details."; render :edit, status: :unprocessable_processable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("edit_item_form_#{@item.id}", partial: "items/form", locals: { item: @item }), status: :unprocessable_entity
        end
      end
      # flash.now[:alert] = "There was a problem updating game details."
      # render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :genre, :platform, :photo, :address, :description)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def record_not_found
    flash[:alert] = "The game you were looking for could not be found."
    redirect_to items_path
  end
end
