class Rental < ApplicationRecord
  belongs_to :user
  has_many :rental_items, dependent: :destroy

  enum :status, {
    active: 0,
    returned: 1,
    overdue: 2,
    cancelled: 3
  }
  
end
