# frozen_string_literal: true

class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  # GET /collections
  def index
    @collections = Collection.with_books.order(name: :asc)
    @books_without_collections = Book.without_collection.limit(4)
  end

  # GET /collections/1
  def show
    @books = @collection
             .books
             .order(created_at: :desc)
             .page(params[:page])
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  def create
    @collection = Collection.new(collection_params)

    if @collection.save
      redirect_to @collection, notice: "Collection was successfully created."
    else
      render :new
    end
  end


  # PATCH/PUT /collections/1
  def update
    if @collection.update(collection_params)
      redirect_to @collection, notice: "Collection was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /collections/1
  def destroy
    @collection.destroy

    redirect_to collections_url, notice: "Collection was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def collection_params
      params.fetch(:collection, {}).permit(:name)
    end
end
