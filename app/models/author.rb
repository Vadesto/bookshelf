# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :author_books, dependent: :restrict_with_error
  has_many :books, through: :author_books
  has_many :five_books, -> { order(created_at: :desc).limit(5) }, through: :author_books, source: :book

  validates :name,
    presence: true,
    uniqueness: true
end
