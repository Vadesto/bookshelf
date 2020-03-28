# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :author_books, dependent: :restrict_with_error
  has_many :books, through: :author_books

  validates :name,
    presence: true,
    uniqueness: true
end
