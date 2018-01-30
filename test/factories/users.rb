FactoryBot.define do
  factory :user do
    first_name            'Sally'
    last_name             'Lowenthal'
    email                 'sally@example.com'
    password              'passpass'
    password_confirmation 'passpass'
  end
end
