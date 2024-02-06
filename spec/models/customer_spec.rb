require 'rails_helper'

RSpec.describe Customer, type: :model do # rubocop:disable Metrics/BlockLength
  it '#full_name - sobrescrevendo o atributo' do
    customer = FactoryBot.create(:customer, name: 'cafezinho')
    expect(customer.full_name).to eq('Sr. cafezinho')
  end

  it '#DEF - Herança' do
    customer = FactoryBot.create(:customer_def)
    expect(customer.vip).to be_falsey
  end

  it '#VIP - Herança' do
    customer = FactoryBot.create(:customer_vip)
    expect(customer.vip).to be_truthy
  end

  it '#full_name' do
    customer = FactoryBot.create(:user)
    expect(customer.full_name).to start_with('Sr. ')
  end

  it 'Usando o attributes_for' do 
    attrs = attributes_for(:customer_def)
    customer = Customer.create(attrs)
    expect(customer.full_name).to start_with('Sr. ')
  end

  it 'atributo transitorio' do
    customer = FactoryBot.create(:customer_def, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'atributo transitorio' do
    customer = FactoryBot.create(:customer_def, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'Cliente Mascolino' do
    customer = create(:customer_male)
    expect(customer.gender).to eq('M')
  end

  it 'Cliente Feminino' do
    customer = create(:customer_female)
    expect(customer.gender).to eq('F')
  end

  it 'Cliente Mascolino vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to be_truthy
  end

  it 'Cliente Mascolino def' do
    customer = create(:customer_male_def)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to be_falsey
  end

  it 'Cliente Feminino vip' do
    customer = create(:customer_female_vip)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to be_truthy
  end

  it 'Cliente Feminino def' do
    customer = create(:customer_female_def)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to be_falsey
  end

  it 'travel_to' do

    travel_to Time.zone.local(2004, 11, 24, 01, 04, 44) do
      @customer = FactoryBot.create(:customer_vip)
    end

    puts Time.now
    puts @customer.created_at
    puts Time.new(2004, 11, 24, 01, 04, 44)
    puts Time.zone.local(2004, 11, 24, 01, 04, 44)

    expect(@customer.created_at).to eq(Time.zone.local(2004, 11, 24, 01, 04, 44))
  end
end
