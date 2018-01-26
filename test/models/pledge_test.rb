require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

  test 'A pledge can be created' do
    pledge = Pledge.create(
      dollar_amount: 99.00,
      project: new_project,
      user: new_user
    )
    pledge.save
    assert pledge.valid?
    assert pledge.persisted?
  end

  test 'owner cannot back own project' do
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    pledge = Pledge.new(dollar_amount: 3.00, project: project)
    pledge.user = owner
    pledge.save
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

  test 'Pledge must have dollar amount' do
     project = new_project
     owner = new_user
     owner.save
     project.user_id = owner.id
     project.save
     user = new_user2
     assert project.invalid?, 'Project should not save with start date in the past'
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
      end_date:    Date.today + 1.month,
      goal:        50000
    )
  end

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  def new_user2
    User.new(
      first_name:            'Bob',
      last_name:             'Doel',
      email:                 'bob@example.com',
      password:              'passpass2',
      password_confirmation: 'passpass2'
    )
  end

  def new_pledge
    Pledge.new(
      dollar_amount: 99.00,
      project: new_project,
      user: new_user2
    )
  end
end
