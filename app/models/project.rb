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
    if start_date && start_date.utc.to_f < Time.now.utc.midnight.to_f
      errors.add(:start_date, "must be in the future")
    end
  end

  def total_amount_pledged
    pledges.sum(:dollar_amount)
  end

  def is_end_date_after_start_date?
    if start_date && end_date &&  end_date.utc.to_f < start_date.utc.to_f
      errors.add(:end_date, "must be after start date")
    end
  end

  def current_user_pledges(current_user)
    if current_user
      pledges.all.where('user_id = ?', current_user.id).all
    else
      []
    end
  end

  def current_user_pledges_sum(current_user)
    current_user_pledges(current_user).sum(:dollar_amount)
  end

  def is_pledged?(current_user)
    if current_user_pledges(current_user).count > 0
      true
    else
      false
    end
  end

  def viewable_progresses(current_user)
    # binding.pry
    if has_met_goal? && is_passed_deadline? && !(is_pledged?(current_user))
      progresses.all.where("created_at < ?", end_date).order(created_at: :desc)
    else
      progresses.all.order(created_at: :desc)
    end
  end

  def is_passed_deadline?
    end_date.utc.to_f < Time.now.utc.to_f
  end

  def has_met_goal?
    pledgetotal = 0

    pledges.each do |pledge|
      pledgetotal += pledge.dollar_amount
    end

    if pledgetotal >= goal
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

  def self.search(term)
    where('title ILIKE ?', "%#{sanitize_sql_like(term)}%")
  end

  def ordered_comments
    comments.all.order(created_at: :desc)
  end

end
