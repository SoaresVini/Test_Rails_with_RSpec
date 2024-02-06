require 'rails_helper'

RSpec.describe Order, type: :model do
  it "belongs_to" do 
    order = FactoryBot.create(:order)
    expect(order.customer).to be_kind_of(Customer)
  end

  it "Tem 3 pedidos - create_list" do
    orders = create_pair(:order)

    expect(orders.count).to eq(2)
  end

  it 'has_many' do
    customer = create(:customer_with_orders)
    puts customer.inspect
    puts customer.orders.inspect
    expect(customer.orders.count).to eq(3)
  end
end
