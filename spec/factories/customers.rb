FactoryBot.define do # rubocop:disable Metrics/BlockLength
  factory :customer, aliases: [:user] do # rubocop:disable Metrics/BlockLength
    transient do
      upcased { false }
      qtt_orders { 3 }
    end

    name { Faker::Name.name }
    address { Faker::Address.street_address }

    # { Faker::Internet.email(domain: 'gmail.com') }
    # sequence(:email, 25) { |n| "meu_email-#{n}@email.com" }
    # sequence(:email, 'a') { |n| "meu_email-#{n}@email.com" }
    sequence(:email) { |n| "meu_email-#{n}@email.com" }

    trait :male do
      gender { 'M' }
    end

    trait :female do
      gender { 'F' }
    end

    trait :vip do
      vip { true }
      days_to_pay { 30 }
    end

    trait :def do
      vip { false }
      days_to_pay { 10 }
    end

    trait :with_orders do
      after(:create) do |customer, evaluator|
        create_list(:order, evaluator.qtt_orders, customer: customer)
      end
    end

    factory :customer_with_orders, traits: [:with_orders]
    factory :customer_male, traits: [:male]
    factory :customer_female, traits: [:female]
    factory :customer_vip, traits: [:vip]
    factory :customer_def, traits: [:def]
    factory :customer_male_vip, traits: [:male,:vip]
    factory :customer_male_def, traits: [:male,:def]
    factory :customer_female_vip, traits: [:female,:vip]
    factory :customer_female_def, traits: [:female, :def]

    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end
  end
end
