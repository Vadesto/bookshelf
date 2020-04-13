# frozen_string_literal: true

class Collection < ApplicationRecord
  has_many :collection_books, dependent: :restrict_with_error
  has_many :books, through: :collection_books
  has_many :five_books, -> { order(created_at: :desc).limit(5) }, through: :collection_books, source: :book

  scope :with_books, -> { left_outer_joins(:books).where.not(books: { id: nil }).distinct }

  validates :name,
    presence: true,
    uniqueness: true
end
