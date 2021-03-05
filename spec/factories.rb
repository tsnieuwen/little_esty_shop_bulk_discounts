FactoryBot.define do
  factory :customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Dessert.variety}
  end

  factory :invoice do
    status {[0,1,2].sample}
    merchant
    customer
  end

  factory :merchant do
    name {Faker::Space.galaxy}
    invoices
    items
  end

  factory :item do
    name {Faker::Coffee.variety}
    description {Faker::Hipster.sentence}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    merchant
  end

  factory :bulk_discount do
    percentage {[0.1, 0.2, 0.3, 0.4, 0.5].sample}
    minimum {[0..20].sample}
    merchant
  end

  factory :transaction do
    result {[0,1].sample}
    credit_card_number {Faker::Finance.credit_card}
    invoice
  end

  factory :invoice_item do
    status {[0,1,2].sample}
    merchant
    invoice
  end
end
