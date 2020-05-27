# frozen_string_literal: true

class BookRentHistoryItem < ApplicationRecord
  belongs_to :book

  validates :since_before_type_cast,
    format: {
      with: /\A\d+-\d{2}-\d{2}\z/,
      allow_blank: true
    }

  validates :since, presence: true

  validates :until_before_type_cast,
    format: {
      with: /\A\d+-\d{2}-\d{2}\z/,
      allow_blank: true
    }

  validates :who, presence: true

  enum status: {
    not_returned: 0,
    returned: 10
  }
end
