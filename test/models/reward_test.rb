require 'test_helper'

class RewardTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  test 'A reward can be created' do
    reward = create(:reward)
    assert reward.valid?, "reward creation should be valid"
    assert reward.persisted?, "reward should be persisted in database"
  end

  test 'A reward cannot be created without a dollar amount' do
    skip
    project = new_project
    project.save
    reward = Reward.create(
      description: 'A heartfelt thanks!',
      project: project
    )
    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  test 'A reward cannot be created without a description' do
    skip
    project = new_project
    project.save
    reward = Reward.create(
      dollar_amount: 99.00,
      project: project
    )
    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end

  # dollar amount positive
  # max_claims positive
  # max_claims integer

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
      end_date:    Date.today + 1.month,
      goal:        50000
    )
  end

end
