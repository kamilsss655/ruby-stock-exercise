require 'rails_helper'
RSpec.describe StocksController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Stock. As you add validations to Stock, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      stock: {
        name: 'Stowa',
        bearer: {
          name: 'Bearer name'
        },
        market_price: {
          currency: 'usd',
          value_cents: 10_000
        }
      }
    }
  }

  let(:invalid_attributes) {
    {
      name: 'invalid',
      bearer: {
        name: 'Bearer name'
      },
      market_price: {
        currency: 'usd',
        value_cents: 10_000
      }
    }
  }

  describe 'GET #index' do
    it 'returns a success response' do
      skip 'to be implemented'
      stock = Stock.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Stock' do
        expect {
          post :create, params: valid_attributes, as: :json
        }.to change(Stock, :count).by(1)
      end

      it 'renders a JSON response with the new stock' do

        post :create, params: valid_attributes, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(stock_url(Stock.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new stock' do

        post :create, params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
      it 'does not create bearer or market price' do
        expect {
          post :create, params: { stock: invalid_attributes }, as: :json
        }.to not_change(Bearer, :count).and not_change(MarketPrice, :count)
      end
    end
  end

  describe 'PUT #update' do
    let!(:stock) { create :stock }
    context 'with valid params' do
      let(:new_attributes) {
        {
          name: 'Stowa Zwei',
          bearer: {
            name: 'Bearer name'
          },
          market_price: {
            currency: 'usd',
            value_cents: 10_000
          }
        }
      }

      it 'updates the requested stock' do
        put :update, params: {stock: new_attributes, id: stock.id}, as: :json
        stock.reload
        expect(stock.name).to eq(new_attributes[:name])
        expect(stock.bearer.name).to eq(new_attributes[:bearer][:name])
        expect(stock.market_price.currency).to eq(new_attributes[:market_price][:currency])
        expect(stock.market_price.value_cents).to eq(new_attributes[:market_price][:value_cents])
      end

      it 'renders a JSON response with the stock' do
        put :update, params: {stock: new_attributes, id: stock.id}, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        json_response = JSON.parse(response.body)
        expect(json_response['name']).to eql(new_attributes[:name])
        skip 'add implementation later'
        expect(json_response['bearer']['name']).to eql(new_attributes[:bearer][:name])
        expect(json_response['market_price']['currency']).to eql(new_attributes[:market_price][:currency])
        expect(json_response['market_price']['value_cents']).to eql(new_attributes[:market_price][:value_cents])
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the stock' do
        put :update, params: {stock: invalid_attributes, id: stock.id}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
      it 'does not create bearer or market price' do
        expect {
          put :update, params: { stock: invalid_attributes, id: stock.id }, as: :json
        }.to not_change(Bearer, :count).and not_change(MarketPrice, :count)
      end
    end

    context 'with attributes matching to existing bearer and market price' do
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
      it 'reassigns to existing bearer and market price' do
        expect {
          put :update, params: { stock: matching_attributes, id: stock.id }, as: :json
        }.to not_change(Bearer, :count).and not_change(MarketPrice, :count)
        stock.reload
        expect(stock.name).to eq(matching_attributes[:name])
        expect(stock.bearer).to eq(existing_bearer)
        expect(stock.market_price).to eq(existing_market_price)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'soft-deletes the existing stock' do
      skip 'to be implemented'
      stock = Stock.create! valid_attributes
      expect {
        delete :destroy, params: {id: stock.to_param}, session: valid_session
      }.to change(Stock, :count).by(-1)
    end
  end
end
