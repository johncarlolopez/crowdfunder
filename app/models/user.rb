class User < ActiveRecord::Base
  has_secure_password
  has_many :projects
  has_many :pledges
  has_many :backed_projects, through: :pledges

  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  # def pledged_projects
  #   user_projects = []
  #   pledges.each do |pledge|
  #     user_projects << pledge.project
  #   end
  #   user_projects.uniq
  # end

  def pledged_projects
    pledges.map { |pledge| pledge.project }.uniq
  end
  # NEED TESTS FOR THIS - SEE SEAN
  def pledged_projects
    pledges.map(&:project).uniq
  end

  def total_pledged
    pledges.sum(:dollar_amount)
  end
end
