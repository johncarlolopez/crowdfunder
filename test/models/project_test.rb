require 'test_helper'


class ProjectTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  test 'valid project can be created' do
    project = build(:project)
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
    project = build(:project)
    project.end_date -= 2.months
    project.save
    assert project.invalid?, 'Project should not save with end date earlier than start date'
  end

  test 'project is invalid without goal being positive' do
    project = build(:project)
    project.goal = -1
    project.save
    assert project.invalid?, 'Project should not save without goal being positive number'
  end

  test 'A category is assiged to a project' do
    project = build(:project, category: nil)
    project.save
    assert project.invalid?
  end

  test 'A project has met their goal' do
    project = build(:project, goal: 5000)
    project.pledges.new(dollar_amount: 5000)
    assert(project.has_met_goal?)
  end

  test 'A project has not met their goal' do
    project = build(:project, goal: 5000)
    project.pledges.new(dollar_amount: 10)
    refute(project.has_met_goal?)
  end

  test 'A project has went above their goal' do
    project = build(:project, goal: 5000)
    project.pledges.new(dollar_amount: 10000)
    assert(project.has_met_goal?)
  end

  test 'How many projects have been pledged too' do
    pledge1 = create(:pledge)
    pledge2 = create(:pledge)
    # binding.pry
    assert_equal( 2, Project.all.sample.num_pledged )
  end

  test 'If the search function returns what it should return' do
    project = create(:project, title: "Test Project")
    # binding.pry
    assert_equal(project, Project.search("Test").first)
  end

  test 'If the search function should not return' do
    project = create(:project, title: "Test Project")
    # binding.pry
    assert_nil( Project.search("xxx").first )
  end

  test 'How much money has been pledged to a project' do
    project = create(:project)
    project.pledges.new(dollar_amount: 25)
    project.pledges.new(dollar_amount: 100)
    project.pledges.new(dollar_amount: 75)

    assert_equal(200, project.total_pledged)
  end

end
