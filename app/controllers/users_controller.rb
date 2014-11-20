class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to games_path, notice: "Thank you for your registration. Now we can play"
    else
      render "new"
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params :update)
        format.html { redirect_to games_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params type=nil
    if type == :update
      params.require(:user).permit(
        :username,
        :epost,
        :admin
      )
    else
      params.require(:user).permit(
        :username,
        :epost,
        :password,
        :password_confirmation
      )
    end
  end

end
