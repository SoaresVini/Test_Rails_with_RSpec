require 'rails_helper'
describe CustomersController, type: :controller do # rubocop:disable Metrics/BlockLength
  describe 'As a Guest' do 
    context '#index' do
      it 'responds successfully' do
        get :index
        expect(response).to be_successful
      end

      it 'responds HTTP 200' do
        get :index
        expect(response).to have_http_status(200)
      end
    end
    # it 'responds a 302 response (not authorized)' do
    #   get :show, params: { id: Customer.first.id }
    #   expect(response).to have_http_status(302)
    # end
  end

  describe 'As Logged Member' do  # rubocop:disable Metrics/BlockLength
    before do
      @member = create(:member)
      @customer = create(:customer)
    end

    it 'Routes' do  
      is_expected.to route(:get, '/customers').to(action: :index)
    end

    it 'Content-Type JSON' do
      customer_params = attributes_for(:customer)
      sign_in(@member)
      post :create, format: :json, params: { customer: customer_params }
      expect(response.content_type).to match('application/json')
    end

    it 'Flash Notice' do
      customer_params = attributes_for(:customer)
      sign_in(@member)
      post :create, params: { customer: customer_params }

      expect(flash[:notice]).to match('Customer was successfully created.')
    end

    it 'With valid attributes' do
      customer_params = attributes_for(:customer)
      sign_in(@member)
      expect {
        post :create, params: { customer: customer_params }
      }.to change(Customer, :count).by(1)
      # customer_params - parametros em Forma de Hash
      # @customer - Objeto
    end

    it 'Not Responds a 200 response' do
      customer_params = attributes_for(:customer, address: nil)
      sign_in(@member)
      expect {
        post :create, params: { customer: customer_params }
      }.not_to change(Customer, :count)
    end

    it 'Responds a 200 response' do
      sign_in(@member)
      get :show, params: { id: @customer.id }
      expect(response).to have_http_status(200)
    end

    it 'render a show template' do
      sign_in(@member)
      get :show, params: { id: @customer.id }
      expect(response).to render_template(:show)
    end
  end
end
