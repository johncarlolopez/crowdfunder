class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :backed_project, class_name: "Project", foreign_key: :project_id

  validates :dollar_amount, presence: true, numericality:{greater_than: 0}
  validates :user, presence: true
  validate :check_if_owner

  def check_if_owner
    if project.user == user
      errors.add(:user, "You can't pledge to your own project")
    end
  end

  def reward_claimed  # this is only called upon creation of a pledge, as it indexes the total_claims column in the rewards table by 1
    project.rewards.order(dollar_amount: :desc).each do |reward|
      # check dollar_amount of pledge vs reward, if they get it and total_claims is less than max_claims, give it
      if (!reward.max_claims && dollar_amount >= reward.dollar_amount) ||  #no max_claims, just give the reward
          (reward.max_claims && dollar_amount >= reward.dollar_amount && reward.total_claims < reward.max_claims)
        # reward.total_claims += 1
        # reward.save
        reward.index_total_claims_by_1
        return reward
      end
    end
    return false
  end
end
