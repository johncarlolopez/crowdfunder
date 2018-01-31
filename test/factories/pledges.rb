FactoryBot.define do
  factory :pledge do
    user
    project
    dollar_amount         5

    trait :small_no_reward do
      dollar_amount       1
    end

    trait :medium_gets_smallest_reward do
      dollar_amount       3
    end

    trait :large_gets_big_reward do
      dollar_amount       11
    end
  end
end
