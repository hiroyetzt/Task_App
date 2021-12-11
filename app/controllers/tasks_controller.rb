class TasksController < ApplicationController
  before_action :set_user, only: [:new, :create, :index, :show, :edit, :update, :destroy] 
  before_action :logged_in_user, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:new, :create, :index, :update, :destroy]
  before_action :correct_user_tasks, only: [:edit, :show]
  
  def new
    @task = Task.new 
  end 
   
  def create
    @task = @user.tasks.new(tasks_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def index
    @tasks = @user.tasks.order(created_at: :desc)
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = @user.tasks.find(params[:id])
    if @task.update_attributes(tasks_params)
      flash[:success] = "更新しました。"
      redirect_to user_task_url
    else
      render :edit
    end
  end
  
  def destroy
    @task = @user.tasks.find(params[:id])
    @task.destroy
    flash[:success] = "「#{@task.task_name}」のデータを削除しました。"
    redirect_to user_tasks_url
  end
    


  private
    def tasks_params
      params.require(:task).permit(:task_name, :task_detail)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def correct_user_tasks
      unless current_user?(@user)
        flash[:danger] = "編集権限がありません"
        redirect_to user_tasks_url(current_user) 
      end
    end
end