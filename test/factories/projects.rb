FactoryBot.define do
  factory :project do
    sequence(:title)        {|num| "Project #{num}"}
    sequence(:description)  {|num| "Description #{num}"}
    goal                    5000
    start_date              {Time.now.utc}
    end_date                {Time.now + 1.month}
    user
    category
  end
end
