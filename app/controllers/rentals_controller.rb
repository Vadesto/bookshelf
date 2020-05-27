# frozen_string_literal: true

class RentalsController < ApplicationController
  before_action :set_book_rent_history_item, only: [:edit, :update, :destroy, :return]

  before_action :set_books, only: [:edit, :update, :new, :create]

  # GET /rentals
  def index
    @book_rent_history_items = BookRentHistoryItem.all
  end

  # GET /rentals/new
  def new
    @book_rent_history_item = BookRentHistoryItem.new
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST rentals
  def create
    @book_rent_history_item = BookRentHistoryItem.new(book_rent_history_item_params)

    if @book_rent_history_item.save
      redirect_to rentals_path, notice: "Book rent history item was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT rentals/1
  def update
    if @book_rent_history_item.update(book_rent_history_item_params)
      redirect_to rentals_path, notice: "Book rent history item was successfully updated."
    else
      render :edit
    end
  end

  # DELETE rentals/1
  def destroy
    @book_rent_history_item.destroy
    redirect_to rentals_path, notice: "Book rent history item was successfully destroyed."
  end

  # POST rentals/1/return
  def return
    @book_rent_history_item.update!(status: "returned")
    redirect_to rentals_path, notice: "Book has been returned."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_rent_history_item
      @book_rent_history_item = BookRentHistoryItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_rent_history_item_params
      params.fetch(:book_rent_history_item, {}).permit(:book_id, :who, :since, :until, :comment, :status)
    end

    def set_books
      @books = Book.all.order(title: :asc).map { |book| [book.title, book.id] }
    end
end
