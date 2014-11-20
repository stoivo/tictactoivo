class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_epost(params[:epost])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to games_path, notice: "Welcome, you are log in :)"
    else
      flash.now.alert = "Epost or Password is wrong"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to games_path, notice: "You are loged out"
  end
end
