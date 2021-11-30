class TasksController < ApplicationController
   
  def new
    @user = User.find(params[:user_id])
    @task = Task.new 
  end 
   
  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.new(tasks_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end
  
  def show
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    if @task.update_attributes(tasks_params)
      flash[:success] = "更新しました。"
      redirect_to user_tasks_url
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.destroy
    flash[:success] = "#{@task.task_name}のデータを削除しました。"
    redirect_to user_tasks_url
  end
    


  private
    def tasks_params
      params.require(:task).permit(:task_name, :task_detail)
    end
end


