class StockService
  attr_accessor :stock, :market_price, :bearer, :params, :errors
  def initialize(params, stock = nil)
    @params = params
    @errors = {}
    initialize_bearer
    initialize_market_price
    initialize_stock(stock)
  end

  def save_stock
    ActiveRecord::Base.transaction do
      build(@bearer)
      build(@market_price)
      build(@stock)
      return @stock
    end
    false
  end

  private

  def initialize_stock(stock)
    if stock
      initialize_stock_for_update(stock)
    else
      initialize_new_stock
    end
  end

  def initialize_new_stock
    @stock ||= Stock.new(name: @params['name'], market_price: @market_price, bearer: @bearer)
  end

  def initialize_stock_for_update(stock)
    stock.assign_attributes(name: @params['name'], market_price: @market_price, bearer: @bearer)
    @stock = stock
  end

  def initialize_bearer
    @bearer = Bearer.find_or_initialize_by(@params['bearer'].to_h)
  end

  def initialize_market_price
    @market_price = MarketPrice.find_or_initialize_by(@params['market_price'].to_h)
  end

  def build(instance)
    return if instance.save
    @errors[human_name(instance)] = instance.errors
    raise ActiveRecord::Rollback
  end

  def human_name(instance)
    instance.class.table_name.singularize
  end
end
