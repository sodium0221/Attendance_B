class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  
  def index
    @users = User.paginate(page: params[:page])
  end 
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end 
  
  def new
    @user = User.new
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
      flash[:success] = 'ユーザー情報を更新しました。'
      redirect_to @user
    else
      flash[:danger] = '更新に失敗しました。'
      render :edit
    end 
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def edit_basic_info
  end 
  
  def update_basic_info
    @users = User.all
      @users.each do |users|
        if users.update_attributes(basic_info_params)
          flash[:success] = "基本時間を更新しました。"
        else
          flash[:danger] = "基本時間の更新は失敗しました。"
        end 
      end 
    redirect_to users_url
  end
  
  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.none
    end 
  end 

  
  private
    
    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end 
    
    def basic_info_params
      params.require(:user).permit(:basic_time, :work_time)
    end 
end
