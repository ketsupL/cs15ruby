require 'json'

puts "Seeding books..."

BookCopy.destroy_all
Book.destroy_all

books_file = File.read(Rails.root.join('db', 'seeds', 'books.json'))
books_data = JSON.parse(books_file)

books_data.each do |book_data|
  book = Book.create!(book_data)

  copies = rand(1..10)
  copies.times do |i|
    book.book_copies.create!(copy_number: i + 1, status: :available)
  end
end

puts "Seeded #{Book.count} books."
