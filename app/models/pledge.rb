class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true, numericality:{greater_than_or_equal_to: 0}
  validates :user, presence: true
  validate :check_if_owner

  def check_if_owner
    if project.user == user
      errors.add(:user, "You can't pledge to your own project")
    end
  end
end
