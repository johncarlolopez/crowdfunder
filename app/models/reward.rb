class Reward < ActiveRecord::Base
  belongs_to :project

  validates :description, :dollar_amount, presence: true

  # add validations for :dollar_amount and :max_claims must be positive

end
