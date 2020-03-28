# frozen_string_literal: true

class Collection < ApplicationRecord
  has_many :collection_books, dependent: :restrict_with_error
  has_many :books, through: :collection_books

  validates :name,
    presence: true,
    uniqueness: true
end
