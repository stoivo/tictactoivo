class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to games_path, notice: "Thank you for your registration. Now we can play"
    else
      render "new"
    end
  end

  def user_params
    params.require(:user).permit(
      :username,
      :epost,
      :password,
      :password_confirmation
      )
  end
end
