class UsersController < ApplicationController
  before_action user_admin, only: [:index]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_admin
    @users = User.all
    if current_user.admin == false
      redirect_to root_path
    else
      render action: "index"
    end
  end
end
