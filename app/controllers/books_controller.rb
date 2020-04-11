# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    @books = Book
             .all
             .order(created_at: :desc)
             .page(params[:page])
  end

  # GET /books/1
  def show
    @books_from_same_collections = Book
                                   .left_outer_joins(:collection_books)
                                   .where(collection_books: { collection: @book.collections })
                                   .where.not(id: @book.id)
                                   .distinct
                                   .limit(6)

    @books_from_same_authors = Book
                               .left_outer_joins(:author_books)
                               .where(author_books: { author: @book.authors })
                               .where.not(id: @book.id)
                               .distinct
                               .limit(6)
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy

    redirect_to books_url, notice: "Book was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.fetch(:book, {})
    end
end
