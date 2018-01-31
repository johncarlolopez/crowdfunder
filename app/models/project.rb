class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner
  belongs_to :category
  has_many :progresses
  has_many :comments

  validates :title, :description, :goal, :start_date, :end_date, :user_id, :category_id, presence: true
  validates :goal, numericality: { greater_than: 0 }
  validate :is_start_date_in_future?
  validate :is_end_date_after_start_date?

  def is_start_date_in_future?
    if start_date.utc.to_f < Time.now.utc.midnight.to_f
      errors.add(:start_date, "Project start date must be in the future")
    end
  end

  def is_end_date_after_start_date?
    if end_date.utc.to_f < start_date.utc.to_f
      errors.add(:end_date, "Project end date must be after start date")
    end
  end

  def has_met_goal?
    pledgetotal = 0

    pledges.each do |pledge|
      pledgetotal += pledge.dollar_amount
    end

    if goal <= pledgetotal
      return true
    else
      return false
    end
  end

  def num_pledged
    project_bool = Project.all.map do |project|
      if project.pledges.any?
        1
      else
        0
      end
    end
    project_bool.sum
  end

  def total_pledged
    pledgetotal = 0

    pledges.each do |pledge|
      pledgetotal += pledge.dollar_amount
    end

    return pledgetotal
  end


end
