require 'test_helper'

class ProgressTest < ActiveSupport::TestCase

  test 'Test only show progress before end date if conditions met' do
    project = create(:project)
    user = create(:user)
    pledge = create(:pledge, dollar_amount: 5000, project: project)
    project.update_attribute(:start_date, Time.now - 1.month)
    project.update_attribute(:end_date, Time.now - 1.day)
    create(:progress, :before_end, project: project)
    create(:progress, :after_end, project: project)
    assert_equal(1, project.viewable_progresses(user).count)
  end

  test 'Test show all progress pledger' do
    project = create(:project)
    user = create(:user)
    pledge = create(:pledge, dollar_amount: 5000, project: project, user: user)
    project.update_attribute(:start_date, Time.now - 1.month)
    project.update_attribute(:end_date, Time.now - 1.day)
    create(:progress, :before_end, project: project)
    create(:progress, :after_end, project: project)
    assert_equal(2, project.viewable_progresses(user).count)
  end
end
