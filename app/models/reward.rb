class Reward < ActiveRecord::Base
  belongs_to :project

  validates :description, :dollar_amount, presence: true
  validates :dollar_amount, :max_claims, numericality: { greater_than: 0 }
  validates :max_claims, numericality: { only_integer: true }

end
