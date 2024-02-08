require 'rails_helper'

RSpec.describe 'Customers', type: :request do #  # rubocop:disable Metrics/BlockLength
  describe 'Testando API' do # rubocop:disable Metrics/BlockLength
    it 'JSON Schema' do
      get '/customers/1.json'
      expect(response).to match_response_schema("customer")
    end

    it 'works! 200 ok' do
      get customers_path
      expect(response).to have_http_status(200)
    end

    it 'INDEX - JSON' do
      get '/customers.json'
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
        [
          {
            id: /\d/,
            name: (be_kind_of String),
            email: (end_with '.com')
          }
        ]
      )
    end

    it 'SHOW RSpec puro - JSON' do
      get '/customers/1.json'
      response_body = JSON.parse(response.body)
      expect(response_body["id"]).to eq(1)
      expect(response_body["name"]).to be_kind_of(String)
      expect(response_body["email"]).to be_kind_of(String)
    end

    it 'SHOW - JSON' do
      get '/customers/1.json'
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
        id: /\d/,
      )
    end

    it 'CREATE - JSON' do
      member = create(:member)
      login_as(member, scope: :member)

      headers = { 'ACCEPT' => 'application/json' }

      customers_params = attributes_for(:customer)
      post '/customers.json', params: { customer: customers_params }, headers: headers

      expect(response.body).to include_json(
        id: /\d/,
        name: customers_params[:name],
        email: customers_params.fetch(:email)
      )
    end

    it 'UPDATE - JSON' do
      member = create(:member)
      login_as(member, scope: :member)

      headers = { 'ACCEPT' => 'application/json' }

      customer = Customer.first
      customer.name += "- ATUALZADOS"
        patch "/customers/#{customer.id}.json", params: { customer: customer.attributes }, headers: headers

      expect(response.body).to include_json(
        id: /\d/,
        name: customer[:name],
        email: customer[:email]
      )
    end

    it 'DESTROY - JSON' do
      member = create(:member)
      login_as(member, scope: :member)

      headers = { 'ACCEPT' => 'application/json' }

      customer = Customer.first
      customer.name += '- ATUALZADOS'

      expect { delete "/customers/#{customer.id}.json", headers: headers }.to change(Customer, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
