# frozen_string_literal: true

class AddUniqueIndexForAuthorName < ActiveRecord::Migration[6.0]
  def change
    add_index :authors, :name, unique: true
  end
end
