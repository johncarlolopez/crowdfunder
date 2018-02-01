class PledgesController < ApplicationController
  before_action :require_login

  def create
    @project = Project.find(params[:project_id])

    @pledge = @project.pledges.build  # what is .build?  seems cool
    @pledge.dollar_amount = params[:pledge][:dollar_amount]
    @pledge.user = current_user

    if @pledge.save
      # run this reward_claimed method on this instance of pledge
      reward = @pledge.reward_claimed
      if reward # reward_claimed will return the reward earned, or false if no reward
        flash[:reward] = "you earned a reward of #{reward.description}"
      end
      redirect_to project_url(@project), notice: "You have successfully backed #{@project.title}!"
    else
      flash.now[:alert] = @pledge.errors.full_messages
      @progress = Progress.new
      @progresses = @project.viewable_progresses(current_user)
      render "projects/show"
    end
  end

end
