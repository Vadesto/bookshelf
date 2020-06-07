# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorize!, only: [:new, :create]

  # GET /sessions/new
  def new
    if logged_in?
      redirect_to root_path, notice: "You are already logged in."
    end
  end

  # POST /sessions
  def create
    user = User.find_by(username: user_params[:username])

    authorized = user&.authenticate(user_params[:password])

    if authorized
      session[:user_id] = user.id

      redirect_to root_path, notice: "You were authorized successfully."
    else
      flash.now[:error] = "Username or password are incorrect."

      render :new
    end
  end

  # DELETE /sessions/1
  def destroy
    session[:user_id] = nil

    redirect_to root_path, notice: "Session was successfully destroyed."
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:username, :password)
    end
end
