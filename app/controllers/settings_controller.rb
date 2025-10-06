class SettingsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    
    # Handle cases where rentals might not exist yet
    begin
      @rental_history = current_user.rentals.includes(:rental_items).order(created_at: :desc)
      @active_rentals = @rental_history.where(status: 'active')
      @past_rentals = @rental_history.where(status: ['returned', 'cancelled'])
    rescue => e
      # If there's an error (like missing table), set empty collections
      Rails.logger.warn "Settings controller error: #{e.message}"
      @rental_history = []
      @active_rentals = []
      @past_rentals = []
    end
  end

  def destroy
    user = current_user
    
    begin
      # Check for active rentals
      active_rentals = user.rentals.where(status: 'active')
      
      if active_rentals.any?
        redirect_to settings_path, alert: "Cannot delete account. You have #{active_rentals.count} active rental(s). Please return all books before deleting your account."
        return
      end

      # Log the account deletion for audit purposes
      Rails.logger.info "Account deletion requested for user: #{user.email} (ID: #{user.id})"
      
      # Sign out the user first
      sign_out(user)
      
      # Delete the user account (this will cascade delete associated rentals due to dependent: :destroy)
      user.destroy!
      
      redirect_to root_path, notice: "Your account has been successfully deleted. Thank you for using CS15 Bookstore."
      
    rescue => e
      Rails.logger.error "Account deletion failed for user #{user.email}: #{e.message}"
      redirect_to settings_path, alert: "Sorry, there was an error deleting your account. Please try again or contact support."
    end
  end
end