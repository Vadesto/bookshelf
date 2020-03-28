# frozen_string_literal: true

class CreateBookRentHistoryItems < ActiveRecord::Migration[6.0]
  def change
    create_table :book_rent_history_items do |t|
      t.date :since, null: false
      t.date :until
      t.string :who, null: false
      t.text :comment
      t.belongs_to :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
