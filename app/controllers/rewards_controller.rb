class RewardsController < ApplicationController
  before_action :load_project

  def new
    @reward = Reward.new
  end

  def create
    @reward = @project.rewards.build(reward_params)

    if !current_user
      redirect_to login_path, alert: 'Please log in'
    elsif current_user != @project.user
      redirect_to project_url(@project), alert: 'You do not own this project'
    elsif @reward.save
      redirect_to project_url(@project), notice: 'Reward created'
    else
      flash.now[:alert] = @reward.errors.full_messages
      render :new
    end
  end

  def destroy
    @reward = Reward.find(params[:id])
    if !current_user
      redirect_to login_path, alert: 'Please log in'
    elsif current_user != @project.user
      redirect_to project_url(@project), alert: 'You do not own this project'
    else
      @reward.destroy
      redirect_to project_url(@project), notice: 'Reward successfully removed'
    end
  end

  private

  def reward_params
    params.require(:reward).permit(:dollar_amount, :description, :max_claims)
  end


  def load_project
    @project = Project.find(params[:project_id])
  end
end
