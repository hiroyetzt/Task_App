class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  def admin_or_correct_user
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "編集権限はありません"
      redirect_to(root_url)
    end
  end
  
  def  logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
  
  def limitation_login_general_user
    if current_user && !current_user.admin?
      flash[:danger] = "すでにログイン状態です。"
      redirect_to user_url(current_user)
    end
  end
  
  def limitation_login_user
    if logged_in?
      flash[:danger] = "すでにログイン状態です。"
      redirect_to user_url(current_user)
    end
  end
end