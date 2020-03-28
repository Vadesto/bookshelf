# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :book_rent_history_items, dependent: :restrict_with_error

  enum status: {
    unreaded: 0,
    wanted: 10,
    reading: 20,
    read: 30,
    delayed: 40
  }

  validates :title, presence: true

  validates :isbn,
    presence: true,
    uniqueness: true,
    numericality: true

  validate :isbn_length

  validates :publish_date_before_type_cast,
    format: {
      with: /\A\d+-\d{2}-\d{2}\z/,
      allow_blank: true
    }

  validates :cover,
    url: {
      schemes: ["https", "http"],
      allow_blank: true
    }

  validates :status, presence: true

  private

    def isbn_length
      unless [10, 13].include?(isbn&.size)
        errors.add(:isbn, "length must be 10 or 13")
      end
    end
end
