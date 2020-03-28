# frozen_string_literal: true

class CreateCollectionBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :collection_books do |t|
      t.belongs_to :collection, null: false, foreign_key: true
      t.belongs_to :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
