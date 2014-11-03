class GoalsController < ApplicationController
  
  def new
    @goal = Goal.new
    render :new
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
    
  end
  
  def destroy
    
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:name, :content, :goal_type)
  end
end
