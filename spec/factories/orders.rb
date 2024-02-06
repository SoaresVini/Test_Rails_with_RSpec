FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedido número - #{n}" }
    # customer # o proprio vai entender que precisa das uma procurada se existe uma fabrica com o famigeraddo 
    association :customer, factory: :customer
  end
end
