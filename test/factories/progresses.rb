FactoryBot.define do
  factory :progress do
    message 'test progress'
    project
    trait :before_end do
      created_at {project.end_date - 2.days}
    end

    trait :after_end do
      created_at {project.end_date + 2.days}
    end

  end
end
