FactoryBot.define do
  factory :pledge do
    user
    dollar_amount   { (1..100).to_a.sample }
    project
  end
end
