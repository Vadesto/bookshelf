# frozen_string_literal: true

class OpenlibraryFindByIsbn < ActiveInteraction::Base
  string :isbn

  validates :isbn,
    presence: true,
    numericality: true

  validate :isbn_length

  def execute
    connection = Faraday.new "http://openlibrary.org/api" do |conn|
      conn.response :json

      conn.adapter Faraday.default_adapter
    end

    key = "ISBN:#{isbn}".to_sym

    resp = connection.get "books", bibkeys: key, format: "json", jscmd: "data"

    data = resp.body.deep_symbolize_keys

    unless data.key? key
      return nil
    end

    data = data[key]

    begin
      data[:publish_date] = Date.parse(data[:publish_date])
    rescue
      data[:publish_date] = nil
    end

    {
      title: data[:title],
      description: data[:subtitle],
      cover: data.dig(:cover, :large),
      publish_date: data[:publish_date],
      authors: data[:authors]&.map { |author| author[:name] } || []
    }
  end

  private

    def isbn_length
      unless [10, 13].include?(isbn&.size)
        errors.add(:isbn, "length must be 10 or 13")
      end
    end
end
