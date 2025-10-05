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
  title: "Naruto",
  author: "Masashi Kishimoto",
  isbn: "9781569319000",
  cover: "https://covers.openlibrary.org/b/isbn/9781569319000.jpg",
  description: "The beginning of Naruto's journey — a young ninja with a dream."
)

book2 = Book.create!(
  title: "Boccher rock",
  author: "bochi rock",
  isbn: "9781569319000",
  cover: "https://upload.wikimedia.org/wikipedia/en/0/08/Bocchi_The_Rock%21_volume_1_cover.jpg",
  description: "bochi the"
)

book3 = Book.create!(
  title: "Fullmetal Alchemist",
  author: "Hiromu Arakawa",
  isbn: "1421541955 ",
  cover: "https://covers.openlibrary.org/b/isbn/1421541955.jpg",
  description: "Edward and Alphonse Elric begin their alchemical journey after tragedy strikes."
)

book4 = Book.create!(
  title: "Attack on Titan",
  author: "Hajime Isayama",
  isbn: "9781612620244",
  cover: "https://covers.openlibrary.org/b/isbn/9781612620244-L.jpg",
  description: "Humanity fights for survival as colossal Titans threaten their existence."
)

book5 = Book.create!(
  title: "Death Note",
  author: "Tsugumi Ohba & Takeshi Obata",
  isbn: "1421539640",
  cover: "https://covers.openlibrary.org/b/isbn/1421539640.jpg",
  description: "Light Yagami discovers a notebook that allows him to kill by writing names."
)

book6 = Book.create!(
  title: "Mein Kampf",
  author: "Adolf Hitler",
  isbn: "9780977476077",
  cover: "https://blackwells.co.uk/jacket/500x500/9781682043776.jpg",
  description: "Auf der heide bluht ein kleines blumelein"
)

# Add copies for each book
3.times do |i|
  book1.book_copies.create!(copy_number: i + 1, status: :available)
end

2.times do |i|
  book2.book_copies.create!(copy_number: i + 1, status: :available)
end

puts "Seeded #{Book.count} books with #{BookCopy.count} copies."