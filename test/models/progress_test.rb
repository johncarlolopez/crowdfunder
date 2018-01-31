require 'test_helper'

class ProgressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Test only show progress before end date if conditions met' do
    project = build(:project)
    project.update_attribute(:start_date, Time.now - 1.month)
    project.update_attribute(:end_date, Time.now - 1.day)
    user = create(:user)
    pledge = create(:pledge, dollar_amount: 5000, project_id: project.id)
    create(:progress, :before_end, project: project)
    create(:progress, :after_end, project: project)
    assert_equal(1, project.viewable_progresses(user).count)
  end

  test 'Test show all progress pledger' do
    project = build(:project)
    project.update_attribute(:start_date, Time.now - 1.month)
    project.update_attribute(:end_date, Time.now - 1.day)
    user = create(:user)
    pledge = create(:pledge, dollar_amount: 5000, project_id: project.id, user: user)
    create(:progress, :before_end, project: project)
    create(:progress, :after_end, project: project)
    assert_equal(2, project.viewable_progresses(user).count)
  end
end
