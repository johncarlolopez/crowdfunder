FactoryBot.define do
  factory :reward do
    project
    description           'Lorem Ipsum'
    dollar_amount         5

    trait :small_no_max do
      dollar_amount       2
    end

    trait :large_w_max do
      dollar_amount       10
      max_claims          1
    end
  end
end
