class RentalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rental, only: [:return, :perform_return]

  def index
    @rentals = current_user.rentals.includes(rental_items: { book_copy: :book })
  end

  def new
    @book = Book.find(params[:book_id])
    @rental = Rental.new
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def create
    book = Book.find(params[:book_id])

    begin
      rental = Rental.rent!(current_user, book)
      
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("modal", "<script>window.location.reload()</script>")
        end
      end

    rescue StandardError => e
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("modal", "<div class='p-4'>#{e.message}</div>")
        end

        format.html { redirect_to books_path, alert: e.message }
      end
    end
  end

  def return
  end

  def perform_return
    @rental = Rental.find(params[:id])
    @rental.return!
    redirect_to rentals_path, notice: "Book returned successfully."
  end

  def set_rental
    @rental = Rental.find(params[:id])
  end

end
