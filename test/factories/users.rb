FactoryBot.define do
  factory :user do
    first_name            'Sally'
    last_name             'Lowenthal'
    sequence(:email)      { |num| "email#{num}@email.com" }
    password              'passpass'
    password_confirmation 'passpass'
  end
end
