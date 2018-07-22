# NOTE: Rails doesn't support foreign_key with SQLlite adapter used here.
# However following will work with Postgres for example.
class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :name
      t.references :bearer, foreign_key: true, index: true
      t.references :market_price, foreign_key: true, index: true
      t.timestamps
    end
  end
end
