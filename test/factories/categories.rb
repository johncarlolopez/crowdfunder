FactoryBot.define do
  factory :category do
    sequence(:name)        { |num| "Category #{num}" }
  end
end
