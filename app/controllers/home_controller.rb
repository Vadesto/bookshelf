# frozen_string_literal: true

class HomeController < ApplicationController
  # GET /
  def index
    @last_books = Book.order(created_at: :desc).limit(11)
    @last_authors = Author.order(created_at: :desc).limit(5)
    @delayed_books = Book.where(status: :delayed).order(created_at: :desc).limit(6)
    @reading_books = Book.where(status: :reading).order(created_at: :desc).limit(6)
  end
end
