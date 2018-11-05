class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :new_bid]

  # bids by owner
  # edit by owner
  # creator in dashboard
  # end date
  # currency

  # GET /items
  # GET /items.json
  def index
    @items = Item.includes(:currency).all
    @items.each do |item|
      coef = get_currency_coef(item.currency.code, current_currency.code)
      item.start_price *= coef
      item.currency = current_currency unless coef == 1
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    item_currency = @item.currency.code
    @bids = @item.bids.order(bid: :desc)
    coef = get_currency_coef(item_currency, current_currency.code)
    @item.start_price *= coef
    @item.currency = current_currency unless coef == 1
    @bids.each do |bid|
      bid.bid *= coef if bid.bid
    end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  def new_bid
    bid_value = Bid.convert_currency(current_currency.code, @item.currency.code, params[:bid_value].to_i)
    if @item.highest_bid < bid_value
      Bid.new(bid: bid_value, item: @item, user: current_user)
    else
      flash[:alert] = 'Your bid is smaller than biggest bid or start price'
    end
    redirect_to item_path(@item.id)
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.user = current_user #create
    Currency.find_or_create_by(code: params['currency']['currency_id'].to_i).items << @item
    respond_to do |format|
      if @item.save
        format.html { redirect_to :root, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :start_price, :end_date)
    end

    def get_currency_coef(first, second)
      CurrencyConverter.new(first, second).convert
    end
end
