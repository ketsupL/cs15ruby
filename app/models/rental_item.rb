class RentalItem < ApplicationRecord
  belongs_to :rental
  belongs_to :book_copy
end
