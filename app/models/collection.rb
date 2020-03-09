# frozen_string_literal: true

class Collection < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: true
end
