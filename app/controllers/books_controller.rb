class BooksController < ApplicationController
  def index
    @books = Book.all
    @book_copies = BookCopy.all
  end
end
