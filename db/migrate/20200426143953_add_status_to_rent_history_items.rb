# frozen_string_literal: true

class AddStatusToRentHistoryItems < ActiveRecord::Migration[6.0]
  def change
    add_column :book_rent_history_items, :status, :integer, null: false, default: 0
  end
end
