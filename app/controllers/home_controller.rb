# frozen_string_literal: true

class HomeController < ApplicationController
  # GET /
  def index
    @collections = Collection.joins(:books).distinct.order(name: :asc)
    @books_without_collections = Book.without_collection.limit(4)
  end
end
