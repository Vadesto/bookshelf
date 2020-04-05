# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @collections = Collection.joins(:books).distinct
    @books_without_collections = Book.left_outer_joins(:collections).where(collections: { id: nil })
  end
end
