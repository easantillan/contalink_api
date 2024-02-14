FactoryBot.define do
  factory :invoice do
    sequence(:id) { |n| n }
    invoice_number { Faker::Number.number(digits: 10) }
    invoice_date { Faker::Date.between(from: '2020-01-01', to: '2022-12-31') }
    total { Faker::Number.decimal(l_digits: 2) }
    status { ["Vigente", "Cancelado"].sample }
  end
end
