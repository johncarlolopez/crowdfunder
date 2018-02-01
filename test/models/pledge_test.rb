require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

  test 'A pledge can be created' do
    pledge = build(:pledge)
    pledge.save
    assert pledge.valid?
    assert pledge.persisted?
  end

  test 'owner cannot back own project' do
    owner = create(:user)
    pledge = build(:pledge, user: owner)
    pledge.project.user = owner
    pledge.save
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

  test 'Pledge must have dollar amount' do
    pledge = build(:pledge, dollar_amount: nil)
    pledge.save
    assert pledge.invalid?, 'Pledge should be invalid if there is no dollar amount'
  end

  test 'Pledge dollar amount must be above zero' do
     pledge = build(:pledge, dollar_amount: 0)
     pledge.save
     assert pledge.invalid?, 'Pledge should be invalid if dollar amount is <= 0'
  end

  test 'Pledge must have a user assigned' do
    pledge = build(:pledge, user: nil)
    pledge.save
    assert pledge.invalid?, 'Pledge should be invalid if no user assigned'
  end

  test 'reward_claimed returns false if no reward earned' do
    reward = create(:reward)
    pledge = create(:pledge, :small_no_reward, project: reward.project)
    refute pledge.reward_claimed, 'reward_claimed should return false if no reward earned'
  end

  test 'total_claims is not indexed if no reward earned' do
    reward = create(:reward)
    pledge = create(:pledge, :small_no_reward, project: reward.project)
    assert_equal(0, reward.total_claims)
  end

  test 'reward_claimed returns reward object if reward earned (no max_claims)' do
    reward = create(:reward, :small_no_max)
    pledge = create(:pledge, :medium_gets_smallest_reward, project: reward.project)
    assert_equal(reward, pledge.reward_claimed)
  end

  test 'total_claims is indexed by 1 if reward earned (no max_claims)' do
    reward = create(:reward, :small_no_max)
    pledge = create(:pledge, :medium_gets_smallest_reward, project: reward.project)
    pledge.reward_claimed
    reward.reload
    assert_equal(1, reward.total_claims)
  end

  test 'reward_claimed returns reward object if reward earned (max_claims specified)' do
    reward = create(:reward, :large_w_max)
    pledge = create(:pledge, :large_gets_big_reward, project: reward.project)
    assert_equal(reward, pledge.reward_claimed)
  end

  test 'reward_claimed returns next lowest available reward if total_claims < max_claims' do
    big_reward = create(:reward, :large_w_max)
    small_reward = create(:reward, :small_no_max, project: big_reward.project)
    pledge1 = create(:pledge, :large_gets_big_reward, project: big_reward.project)
    pledge2 = create(:pledge, :large_gets_big_reward, project: big_reward.project)
    pledge1.reward_claimed
    assert_equal(small_reward, pledge2.reward_claimed)
  end

  test 'reward_claimed returns false if all rewards total_claims at max_claims' do
    big_reward = create(:reward, :large_w_max)
    pledge1 = create(:pledge, :large_gets_big_reward, project: big_reward.project)
    pledge2 = create(:pledge, :large_gets_big_reward, project: big_reward.project)
    pledge1.reward_claimed
    refute pledge2.reward_claimed, 'reward_claimed should return false if all available rewards total_claims at max_claims'
  end
end
