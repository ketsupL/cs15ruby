# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Seeding books..."

BookCopy.destroy_all
Book.destroy_all

book1 = Book.create!(
  title: "The Pragmatic Programmer",
  author: "Andrew Hunt & David Thomas",
  isbn: "9780135957059",
  cover: "https://covers.openlibrary.org/b/id/8231991-L.jpg",
  description: "A classic programming book about pragmatic practices."
)

book2 = Book.create!(
  title: "Clean Code",
  author: "Robert C. Martin",
  isbn: "9780132350884",
  cover: "https://covers.openlibrary.org/b/id/8155416-L.jpg",
  description: "How to write clean and maintainable code."
)

# Add copies for each book
3.times do |i|
  book1.book_copies.create!(copy_number: i + 1, status: :available)
end

2.times do |i|
  book2.book_copies.create!(copy_number: i + 1, status: :available)
end

puts "Seeded #{Book.count} books with #{BookCopy.count} copies."