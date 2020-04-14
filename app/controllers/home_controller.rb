# frozen_string_literal: true

class HomeController < ApplicationController
  # GET /
  def index
    @last_books = Book.order(created_at: :desc).limit(11)
  end
end
