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

  def new_password_reset
  end
  def reset_one_user_by_email
    @user = User.where(epost: params[:epost]).first
    if @user
      @user.send_password_reset
      redirect_to games_path, notice: "An Email sent to you mail address"
    else
      redirect_to games_path, notice: "No uses with that email"
    end

  end
  def edit_password
    @user = User.find_by_password_reset_token! params[:user_id]
  end
  def update_only_password
    @user = User.find_by_password_reset_token! params[:user_id]
    if @user.password_reset_sent_at < 2.hour.ago
      redirect_to user_new_password_reset_path(0), alert: "Password reset has expired"
    elsif @user.update_attributes user_params :password
      redirect_to games_path, notice: "Password has been reset!"
    else
      render :edit_password
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
    elsif type == :password
      params.require(:user).permit(
        :password,
        :password_confirmation
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
