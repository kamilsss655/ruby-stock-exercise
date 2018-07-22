class StockSerializer < ActiveModel::Serializer
  attributes :id, :name, :updated_at, :created_at
  belongs_to :bearer
  belongs_to :market_price
end
