require 'test_helper'


class ProjectTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def setup
    @owner = create(:user)
  end

  test 'valid project can be created' do
    project = build(:project, user: @owner)
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user

  end

  test 'project is invalid without owner' do
    project = build(:project, user: nil)
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  test 'project is invalid with end date before start date' do
    project = build(:project, user: @owner)
    project.end_date -= 2.months
    project.save
    assert project.invalid?, 'Project should not save with end date earlier than start date'
  end

  test 'project is invalid without goal being positive' do
    project = build(:project, user: @owner)
    project.goal = -1
    project.save
    assert project.invalid?, 'Project should not save without goal being positive number'
  end

  test 'A category is assiged to a project' do
    project = build(:project, user: @owner, category: nil)
    project.save
    assert project.invalid?
  end
end
