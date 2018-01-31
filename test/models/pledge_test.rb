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
end
