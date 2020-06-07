# frozen_string_literal: true

class OpenlibraryImportByIsbn < ActiveInteraction::Base
  string :isbn

  validates :isbn,
    presence: true,
    numericality: true

  validate :isbn_length

  def execute
    book = OpenlibraryFindByIsbn.run(isbn: isbn)

    unless book.valid?
      errors.merge!(book.errors)

      return nil
    end

    if Book.exists?(isbn: isbn)
      errors.add(:isbn, "This book already exists")

      return nil
    end

    created = nil

    book = book.result

    ActiveRecord::Base.transaction do
      created = Book.create!(
        isbn: isbn,
        title: book[:title],
        description: book[:description],
        cover: book[:cover],
        publish_date: book[:publish_date],
        status: :unreaded
      )

      book[:authors].each do |name|
        author = Author.find_or_create_by!(name: name)

        AuthorBook.create!(
          book: created,
          author: author
        )
      end
    end

    created
  end

  private

    def isbn_length
      unless [10, 13].include?(isbn&.size)
        errors.add(:isbn, "length must be 10 or 13")
      end
    end
end
