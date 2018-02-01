require 'test_helper'

class RewardTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  test 'A reward can be created without max_claims specified' do
    reward = create(:reward)
    assert reward.valid?, "reward creation should be valid"
    assert reward.persisted?, "reward should be persisted in database"
  end

  test 'A reward can be created with valid max_claims specified' do
    reward = create(:reward, max_claims: 1)
    assert reward.valid?, "reward creation should be valid with valid max_claims given"
    assert reward.persisted?, "reward should be persisted in database with valid max_claims given"
  end

  test 'A reward cannot be created without a dollar amount' do
    reward = build(:reward, dollar_amount: nil)
    reward.save
    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  test 'A reward cannot be created with a negative or zero dollar amount' do
    reward = build(:reward, dollar_amount: 0)
    reward.save
    assert reward.invalid?, 'Reward should be invalid with dollar amount <= 0'
    assert reward.new_record?, 'Reward should not save with dollar amount <=0'
  end

  test 'A reward cannot be created without a description' do
    reward = build(:reward, description: nil)
    reward.save
    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end

  test 'A reward cannot be created with max_claims equal to or less than zero' do
    reward = build(:reward, max_claims: 0)
    reward.save
    assert reward.invalid?, 'Reward should be invalid with max_claims <= 0'
    assert reward.new_record?, 'Reward should not save with max_claims <= 0'
  end

  test 'A reward cannot be created with max_claims being non-integer' do
    reward = build(:reward, max_claims: 0.1)
    reward.save
    assert reward.invalid?, 'Reward should be invalid with max_claims being non-integer'
    assert reward.new_record?, 'Reward should not save with max_claims being non-integer'
  end
end
