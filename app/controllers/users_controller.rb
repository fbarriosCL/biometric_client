class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]
  before_action :user_service, only: [:index, :new]
  before_action :set_service_user, only: [:create, :update, :authentication]

  def index
    @users = @user.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'ok' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(params[:id])
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    UserService.new.destroy(@user['id'])
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  def login
  end

  def authentication
    respond_to do |format|
      if @user.verify_user(request.user_agent)
        format.html { redirect_to login_user_path, notice: @user.verify_user(request.user_agent) }
      else
        format.html { render :login }
      end
    end
  end

  private

  def set_user
    @user = OpenStruct.new(user_service.find(params[:id]))
  end

  def user_service
    @user = UserService.new
  end

  def set_service_user
    @user = UserService.new(user_params) rescue UserService.new
  end

  def user_params
    params.require(:user).permit(:email, :image)
  end
end
