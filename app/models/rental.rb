class Rental < ApplicationRecord
  belongs_to :user
  has_many :rental_items, dependent: :destroy

  enum :status, {
    active: 0,
    returned: 1,
    overdue: 2
  }

  def self.rent!(user, book)
    book_copy = book.book_copies.available.first
    raise StandardError, "No available copies for this book." if book_copy.nil?

    transaction do
      rental = user.rentals.create!(
        status: :active,
        rented_at: Time.current,
        due_date: 7.days.from_now
      )
      rental.rental_items.create!(book_copy: book_copy)
      book_copy.update!(status: :checked_out)
      rental
    end
  end

  def return!
    transaction do
      rental_items.each { |item| item.book_copy.update!(status: :available) }
      update!(status: :returned, returned_at: Time.current)
    end
  end

  def check_overdue!
    if active? && due_date.present? && Time.current > due_date
      update!(status: :overdue)
    end
  end
  
end
