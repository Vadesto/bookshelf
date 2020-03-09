# frozen_string_literal: true

class Book < ApplicationRecord
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
    numericality: true,
    length: { in: [10, 13] }

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
end
