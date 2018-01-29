class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @projects = Project.all
    @projects = @projects.order(:end_date)
  end

  def show
    @project = Project.find(params[:id])
    @pledges = @project.pledges
    # Calculate total amount pledge to project
    @total_amount_pledged = @pledges.sum(:dollar_amount)
    # Default pledge to project as false unless there are pledges by user to project
    if current_user
      @my_pledges = @pledges.all.where('user_id = ?', current_user.id).all
      if @my_pledges.count > 0
        @my_total_pledged_to_project = 0
        @is_pledged_to_project = true
        @my_pledges.each {|pledge|
          @my_total_pledged_to_project += pledge.dollar_amount
        }
      else
        @is_pledged_to_project = false
      end
    end
  end

  def new
    @project = Project.new
    @project.rewards.build
  end

  def create
    @project = Project.new
    @project.title = params[:project][:title]
    @project.description = params[:project][:description]
    @project.goal = params[:project][:goal]
    @project.start_date = params[:project][:start_date]
    @project.end_date = params[:project][:end_date]
    @project.image = params[:project][:image]
    @project.user = current_user
    @project.category_id = params[:project][:category_id]

    if @project.save
      redirect_to projects_url
    else
      flash.now[:alert] = @project.errors.full_messages
      render :new
    end
   end

end
