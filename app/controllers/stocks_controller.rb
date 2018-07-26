class StocksController < ApplicationController
  before_action :set_stock, only: %i[update destroy]
  # GET /stocks
  def index
    @stocks = Stock.all.includes(%i[bearer market_price])
    render json: @stocks
  end

  def create
    @stock_service = StockService.new(stock_params)
    if @stock_service.save_stock
      render json: @stock_service.stock, status: :created, location: @stock_service.stock
    else
      render json: @stock_service.errors, status: :unprocessable_entity
    end
  end

  def update
    @stock_service = StockService.new(stock_params, @stock)
    if @stock_service.save_stock
      render json: @stock_service.stock
    else
      render json: @stock_service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @stock.soft_delete
  end

  private

  def set_stock
    @stock = Stock.find(params['id'])
  end

  def stock_params
    params
      .require(:stock)
      .permit(
        :name,
        bearer: :name,
        market_price: %i[currency value_cents])
  end
end
