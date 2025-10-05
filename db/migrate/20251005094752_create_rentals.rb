class CreateRentals < ActiveRecord::Migration[8.0]
  def change
    create_table :rentals do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :rented_at
      t.datetime :due_date
      t.datetime :returned_at
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
