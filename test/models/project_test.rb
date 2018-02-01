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
    assert_equal( 2, Project.all.sample.num_pledged )
  end

  test 'If the search function returns what it should return' do
    project = create(:project, title: "Test Project")
    assert_equal(project, Project.search("Test").first)
  end

  test 'If the search function should not return' do
    project = create(:project, title: "Test Project")
    assert_nil( Project.search("xxx").first )
  end

  test 'How much money has been pledged to a project' do
    project = create(:project)
    project.pledges.new(dollar_amount: 25)
    project.pledges.new(dollar_amount: 100)
    project.pledges.new(dollar_amount: 75)

    assert_equal(200, project.total_pledged)
  end

  test 'Total amount pledge returns correct sum' do
    project = create(:project)
    create(:pledge, project: project, dollar_amount: 20)
    create(:pledge, project: project, dollar_amount: 30)
    create(:pledge, dollar_amount: 20)
    assert_equal(50, project.total_amount_pledged, 'total_amount_pledged should return the sum of only pledges belonging to project')
  end

  test 'Current_user_pledges returns only pledges of project for user' do
    project = create(:project)
    user = create(:user)
    first_pledge_in_project = create(:pledge, project: project, user: user)
    second_pledge_in_project = create(:pledge, project: project, user: user)
    pledge_not_in_project = create(:pledge, user: user)
    pledge_in_project_not_user = create(:pledge, project: project,)
    assert_equal(true, project.current_user_pledges(user).include?(first_pledge_in_project), 'current_user_pledges must return a pledge included in project')
    assert_equal(true, project.current_user_pledges(user).include?(second_pledge_in_project), 'current_user_pledges must return a pledge included in project')
    assert_equal(false, project.current_user_pledges(user).include?(pledge_not_in_project), 'current_user_pledges must not return a pledge not included in project')
    assert_equal(false, project.current_user_pledges(user).include?(pledge_in_project_not_user), 'current_user_pledges must not return a pledge in project but not by user')
  end


end
