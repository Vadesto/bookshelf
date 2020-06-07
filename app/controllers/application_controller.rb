# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorize!

  include SessionsHelper

  private

    def authorize!
      redirect_to new_session_path, notice: "You need to be logged in to access this page!" if logged_out?
    end
end
