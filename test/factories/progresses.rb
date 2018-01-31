FactoryBot.define do
  factory :progress do
    message 'test progress'
    project
    trait :before_end do
      created_at {project.end_date - 1.day}
    end

    trait :after_end do
      created_at {project.end_date + 1.day}
    end

  end
end
