class GoalsController < ApplicationController
  before_action :redirect_unless_goal_belongs_to_current_user, only: :complete
  def new
    @goal = Goal.new
    render :new
  end
  
  def complete
    @goal = Goal.find(params[:goal_id])
    @goal.toggle(:completed)
    @goal.save!
    
    redirect_to user_url(@goal.goal_setter)
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.goal_setter = current_user
    
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new 
    end
  end
  
  def show
    @goal = Goal.find(params[:id])
    render :show
  end
  
  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end
  
  def update
    @goal = Goal.find(params[:id])
    
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:name, :content, :goal_type)
  end
  
  def redirect_unless_goal_belongs_to_current_user
    redirect_to root_url unless current_user == Goal.find(params[:goal_id]).goal_setter
  end
end
