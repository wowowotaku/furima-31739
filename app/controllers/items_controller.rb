class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :reject_edit, only: :edit


  def index
    @items = Item.all.order(id: 'DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end


  def destroy
    if current_user == @item.user
      @item.destroy
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :item_name, :explain, :category_id, :status_id, :shippingfee_id, :from_id, :day_id,
                                 :price).merge(user_id: current_user.id)
  end

  def reject_edit
    redirect_to root_path unless current_user == @item.user
  end
end
