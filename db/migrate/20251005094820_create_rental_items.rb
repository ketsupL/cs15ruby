class CreateRentalItems < ActiveRecord::Migration[8.0]
  def change
    create_table :rental_items do |t|
      t.references :rental, null: false, foreign_key: true
      t.references :book_copy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
