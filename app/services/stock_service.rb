class StockService
  attr_accessor :stock, :market_price, :bearer, :params, :errors
  def initialize(params, stock = nil)
    @stock = stock
    @params = params
    @errors = []
  end

  def create_stock
    ActiveRecord::Base.transaction do
      build_with_errors(initialize_bearer)
      build_with_errors(initialize_market_price)
      build_with_errors(initialize_new_stock)
      return @stock
    end
    false
  end

  def update_stock
    ActiveRecord::Base.transaction do
      build_with_errors(initialize_bearer)
      build_with_errors(initialize_market_price)
      build_with_errors(initialize_stock_for_update)
      return @stock
    end
    false
  end

  private

  def initialize_new_stock
    @stock ||= Stock.new(name: @params['name'], market_price: @market_price, bearer: @bearer)
  end

  def initialize_stock_for_update
    raise 'No stock provided as param!' if @stock.nil?
    @stock.assign_attributes(name: @params['name'], market_price: @market_price, bearer: @bearer)
    @stock
  end

  def initialize_bearer
    @bearer = Bearer.find_or_initialize_by(@params['bearer'].to_h)
  end

  def initialize_market_price
    @market_price = MarketPrice.find_or_initialize_by(@params['market_price'].to_h)
  end

  def build_with_errors(instance)
    return if instance.save
    @errors << instance.errors
    raise ActiveRecord::Rollback
  end
end
