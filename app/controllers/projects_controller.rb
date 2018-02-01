class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @projects = Project.all
    @projects = @projects.order(:end_date)
    @projects = if params[:term]
      Project.search(params[:term])
        else
      Project.all
    end
  end

  def home
    @projects = Project.all
    @num_projects = Project.first.num_pledged
  end

  def show
    @project = Project.find(params[:id])
    @pledge = Pledge.new(project: @project)
    @comment = Comment.new
    @progress = Progress.new
    # Collection of comments and progresses to be shown on page
    @comments = @project.comments.all.order(created_at: :desc)
    @progresses = @project.viewable_progresses(current_user)
  end

  def new
    @project = Project.new
    @project.rewards.build
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.image == ""
      @project.update(image: "http://americanconstruction.net/wp-content/uploads/2015/10/upload-empty.png")
    end
    if @project.save
      redirect_to projects_url
    else
      flash.now[:alert] = @project.errors.full_messages
      render :new
    end
   end

   def create_progress
     @progress = Progress.new
     @progress.message = params[:progress][:message]
     @progress.user = current_user
     @progress.project_id = params[:id]
     if @progress.save
       redirect_to project_url(params[:id])
     else
       flash.now[:alert] = @progress.errors.full_messages
       render :show
     end
   end

   def create_comment
     @comment = Comment.new
     @comment.message = params[:comment][:message]
     @comment.user = current_user
     @comment.project_id = params[:id]
     if @comment.save
       redirect_to project_url(params[:id])
     else
       flash.now[:alert] = @comment.errors.full_messages
       render :show
     end
   end

   def project_params
     params.require(:project).permit(:title, :description, :goal, :start_date, :end_date, :image, :category_id, :term)
   end

end
