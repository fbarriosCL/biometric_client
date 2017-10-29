class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]
  before_action :new_user, only: [:create, :update, :authentication]

  def index
    @users = User.new.all
  end

  def show
  end

  def new
    @user = User.new
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
    User.new.destroy(@user['id'])
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  def login
  end

  def authentication
    respond_to do |format|
      if @user.verify_user
        format.html { redirect_to login_user_path, notice: @user.verify_user }
      else
        format.html { render :login }
      end
    end
  end

  private
  def new_user
    @user = User.new(user_params)
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = OpenStruct.new(User.new.find(params[:id]))
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :image)
  end
end
