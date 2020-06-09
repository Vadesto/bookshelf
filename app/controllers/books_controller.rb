# frozen_string_literal: true

class BooksController < ApplicationController
  skip_before_action :authorize!, only: [:show, :index]

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    query = nil

    if params[:q].present?
      query = {
        m: "or",
        title_cont: params[:q],
        isbn_eq: params[:q],
        authors_name_cont: params[:q]
      }
    end

    @q = Book.ransack(query)

    @books = @q.result(distinct: true)
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
    @book.destroy!

    redirect_to books_url, notice: "Book was successfully destroyed."
  end

  # GET /books/import_by_isbn
  def import_by_isbn
  end

  # POST /books/import_preview
  def import_preview
    book = OpenlibraryFindByIsbn.run(isbn: import_params[:isbn])

    unless book.valid?
      return redirect_to import_by_isbn_books_url, flash: { error: "Invalid ISBN" }
    end

    if Book.exists?(isbn: import_params[:isbn])
      return redirect_to import_by_isbn_books_url, flash: { error: "This book already exists" }
    end

    @book_data = book.result

    if @book_data.blank?
      redirect_to import_by_isbn_books_url, flash: { error: "Sorry, we couldn't find this book" }
    end

    @isbn = import_params[:isbn]
  end

  # Submiting import by ISBN
  # POST /books/submit_import
  def submit_import
    book = OpenlibraryImportByIsbn.run(isbn: import_params[:isbn])

    unless book.valid?
      return redirect_to import_by_isbn_books_url, flash: { error: "Import error" }
    end

    redirect_to book.result
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.fetch(:book, {}).permit(:title, :isbn, :image, :status, :cover)
    end

    # Only allow ISBN param
    def import_params
      params.permit(:isbn)
    end
end
