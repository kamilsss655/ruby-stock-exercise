require 'rails_helper'
RSpec.describe StockService do
  let(:valid_attributes) {
    {
      'name' => 'Stowa',
      'bearer' => {
        'name' => 'Bearer name'
      },
      'market_price' => {
        'currency' => 'usd',
        'value_cents' => 10_000
      }
    }
  }
  let(:invalid_attributes) {
    {
      'name' => 'Daniel Wellington',
      'bearer' => {
        'name' => 'invalid'
      },
      'market_price' => {
        'currency' => 'usd',
        'value_cents' => 10_000
      }
    }
  }

  describe '#create_stock' do
    let!(:stock) { create :stock }
    let!(:existing_market_price) { create :market_price_x_1 }
    let!(:existing_bearer) { create :bearer_x_1 }
    let(:matching_attributes) {
      {
        name: 'Omega',
        bearer: {
          name: existing_bearer.name
        },
        market_price: {
          currency: existing_market_price.currency,
          value_cents: existing_market_price.value_cents
        }
      }
    }
    context 'with valid attributes' do
      context 'with non-existing bearer and stock' do
        it 'creates bearer and stock' do
          stock_service = StockService.new(valid_attributes)
          expect {
            stock_service.create_stock
          }.to change(Stock, :count).by(1)
           .and change(MarketPrice, :count).by(1)
           .and change(Bearer, :count).by(1)
        end
      end
      context 'with existing bearer and stock' do
        it 'it create stock with existing market price and bearer' do
          stock_service = StockService.new(matching_attributes)
          expect {
            stock_service.create_stock
          }.to change(Stock, :count).by(1)
           .and not_change(MarketPrice, :count)
           .and not_change(Bearer, :count)
        end
      end
    end
    context 'with valid attributes' do
      let(:stock_service) { StockService.new(invalid_attributes) }
      it 'returns false' do
        expect(stock_service.create_stock).to eq(false)
      end
      it 'does not create market_price, stock, bearer' do
        expect {
          stock_service.create_stock
        }.to not_change(Stock, :count)
         .and not_change(MarketPrice, :count)
         .and not_change(Bearer, :count)
      end
    end
  end
  describe '#update_stock' do
    context 'with valid attributes' do
      let(:new_attributes) {
        {
          'name' => 'Panerai',
          'bearer' => {
            'name' => 'News'
          },
          'market_price' => {
            'currency' => 'chf',
            'value_cents' => 220_010
          }
        }
      }
      let!(:stock) { create :stock }
      context 'with non-existing bearer and stock' do
        it 'creates bearer and stock' do
          stock_service = StockService.new(new_attributes, stock)
          expect {
            stock_service.update_stock
          }.to not_change(Stock, :count)
           .and change(stock, :name)
           .and change(MarketPrice, :count).by(1)
           .and change(Bearer, :count).by(1)
        end
      end
      context 'with existing bearer and stock' do
        let!(:existing_market_price) { create :market_price_x_1 }
        let!(:existing_bearer) { create :bearer_x_1 }
        let(:matching_attributes) {
          {
            name: 'Omega',
            bearer: {
              name: existing_bearer.name
            },
            market_price: {
              currency: existing_market_price.currency,
              value_cents: existing_market_price.value_cents
            }
          }
        }
        it 'reassigns existing market price and bearer to stock' do
          stock_service = StockService.new(matching_attributes, stock)
          expect { stock_service.update_stock }.to not_change(Stock, :count)
            .and change(stock, :name)
            .and not_change(MarketPrice, :count)
            .and not_change(Bearer, :count)
        end
      end
    end
  end
  describe '#errors' do
    context 'with valid params' do
      it 'it returns {}' do
        stock_service = StockService.new(valid_attributes)
        stock_service.create_stock
        expect(stock_service.errors).to eq({})
      end
    end
    context 'with invalid params' do
      it 'it returns errors' do
        stock_service = StockService.new(invalid_attributes)
        stock_service.create_stock
        expect(stock_service.errors).to_not eq({})
      end
    end
  end
end
