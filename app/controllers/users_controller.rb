class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      session[:user_id] = @user.id
      redirect_to projects_url
    else
      flash[:errors] = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @projects = @user.projects  # projects the user owns
    @pledged_projects = pledged_projects  #array of projects user donated to
    @total_pledged = total_pledged  # total pledged through @pledged_projects
  end

  private

  def pledged_projects
    user_projects = []
    user_pledges = @user.pledges
    user_pledges.each do |pledge|
      user_projects << pledge.project
    end
    user_projects.uniq
  end

  def total_pledged
    @user.pledges.sum(:dollar_amount)
  end
end
