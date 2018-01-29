require 'test_helper'


class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  test 'project is invalid without owner' do
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  test 'project is invalid with end date before start date' do
    project = new_project
    owner = new_user
    owner.save
    project.user = owner
    project.end_date -= 2.months
    project.save
    assert project.invalid?, 'Project should not save with end date earlier than start date'
  end

  test 'project is invalid without goal being positive' do
    project = new_project
    owner = new_user
    owner.save
    project.user = owner
    project.goal = -1
    project.save
    assert project.invalid?, 'Project should not save without goal being positive number'
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today + 1.day,
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

end
