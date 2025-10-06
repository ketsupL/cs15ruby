class BookCopy < ApplicationRecord
  belongs_to :book
  has_many :rental_items, dependent: :destroy

  enum :status, { available: 0, checked_out: 1}
end
