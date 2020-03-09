# frozen_string_literal: true

class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :collections, :name, unique: true
  end
end
