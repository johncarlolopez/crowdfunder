class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :backed_project, class_name: "Project", foreign_key: :project_id

  validates :dollar_amount, presence: true, numericality:{greater_than: 0}
  validates :user, presence: true
  validate :check_if_owner
  validate :is_date_before_project_end?

  def check_if_owner
    if project.user == user
      errors.add(:user, "You can't pledge to your own project")
    end
  end

  def is_date_before_project_end?
    if Time.now.utc.to_f < project.end_date.utc.to_f
      return true
    else
      errors.add(:user, "You can't pledge project that's ended")
      return false
    end
  end


  def reward_claimed  # this is only called upon creation of a pledge, as it indexes the total_claims column in the rewards table by 1
    project.rewards.order(dollar_amount: :desc).each do |reward|
      # check dollar_amount of pledge vs reward, if they get it and total_claims is less than max_claims, give it
      if (!reward.max_claims && dollar_amount >= reward.dollar_amount) ||  #no max_claims, just give the reward
          (reward.max_claims && dollar_amount >= reward.dollar_amount && reward.total_claims < reward.max_claims)
        reward.increment(:total_claims).save
        return reward
      end
    end
    return false
  end
end
