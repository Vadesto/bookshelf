# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :isbn, null: false
      t.string :title, null: false
      t.date :publish_date
      t.text :cover
      t.text :description
      t.integer :status, null: false

      t.timestamps
    end
    add_index :books, :isbn, unique: true
  end
end
