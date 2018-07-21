class StocksController < ApplicationController
  # GET /stocks
  def index
    @stocks = Stock.all.includes(%i[bearer market_price])
    render json: @stocks
  end

  def create
    @stock_service = StockService.new(stock_params)
    if @stock_service.create
      render json: @stock_service.stock, status: :created, location: @stock_service.stock
    else
      render json: @stock_service.errors, status: :unprocessable_entity
    end
  end

  def update
    @stock_service = StockService.new(stock_params, Stock.find(params['id']))
    if @stock_service.update
      render json: @stock_service.stock
    else
      render json: @stock_service.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stocks/1
  def destroy
    @stock.destroy
  end

  private

  def stock_params
    params
      .require(:stock)
      .permit(
        :name,
        bearer: :name,
        market_price: %i[currency value_cents])
  end
end
