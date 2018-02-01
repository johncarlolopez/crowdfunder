class Reward < ActiveRecord::Base
  belongs_to :project

  validates :description, :dollar_amount, presence: true
  validates :dollar_amount, numericality: { greater_than: 0 }
  validate :when_max_claims_supplied_must_be_integer,
          :when_max_claims_supplied_must_be_greater_than_zero

  def when_max_claims_supplied_must_be_integer
    if max_claims.present? && !max_claims.integer?
      errors.add(:max_claims, ", if supplied, must be an integer")
    end
  end

  def when_max_claims_supplied_must_be_greater_than_zero
    if max_claims.present? && max_claims <= 0
      errors.add(:max_claims, ", if supplied, must be a positive number")
    end
  end
end
