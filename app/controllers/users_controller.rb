class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :show, :update, :destroy]
  before_action :admin_user, only: [:index, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :limitation_login_general_user, only: :new
  
  
  
  def show
  end

  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
    
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    if @user.destroy
      flash[:success] = "#{@user.name}を削除しました。"
      redirect_to users_url
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
   
   def set_user
      @user = User.find(params[:id])
   end

end
