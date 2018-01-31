FactoryBot.define do
  factory :categories do
    sequence(:category)        {|num| "Category #{num}"}
  end
end
