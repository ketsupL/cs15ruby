import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "confirmInput", "deleteButton", "deleteForm"]

  connect() {
    console.log("Settings controller connected", this.element)
    // Ensure the delete button starts disabled
    if (this.hasDeleteButtonTarget) {
      this.deleteButtonTarget.disabled = true
    }
  }

  showDeleteModal(event) {
    event.preventDefault()
    this.modalTarget.classList.remove("hidden")
    // Don't auto-focus to prevent browser warnings
    // User can manually click the input field
  }

  hideDeleteModal(event) {
    event.preventDefault()
    this.modalTarget.classList.add("hidden")
    // Reset form state
    this.confirmInputTarget.value = ""
    this.deleteButtonTarget.disabled = true
  }

  validateConfirmation(event) {
    const input = event.target.value.trim()
    const deleteButton = this.deleteButtonTarget
    
    if (input === "DELETE") {
      deleteButton.disabled = false
      deleteButton.classList.remove("opacity-50", "cursor-not-allowed")
    } else {
      deleteButton.disabled = true
      deleteButton.classList.add("opacity-50", "cursor-not-allowed")
    }
  }

  handleAccountDeletion(event) {
    // Double-check confirmation
    if (this.confirmInputTarget.value.trim() !== "DELETE") {
      event.preventDefault()
      alert("Please type 'DELETE' to confirm account deletion.")
      return false
    }

    // Final confirmation
    const confirmed = confirm("This is your final chance. Are you absolutely sure you want to delete your account? This action cannot be undone.")
    
    if (!confirmed) {
      event.preventDefault()
      return false
    }

    // If we get here, let the form submit
    const button = this.deleteButtonTarget
    const originalText = button.value
    button.value = "Deleting Account..."
    button.disabled = true
    
    // Set a timeout to reset the button if something goes wrong
    setTimeout(() => {
      if (button.value === "Deleting Account...") {
        button.value = originalText
        button.disabled = false
        console.error("Delete operation timed out - resetting button")
      }
    }, 10000) // Reset after 10 seconds if no response
    
    return true
  }

  // Close modal when clicking outside
  modalClicked(event) {
    if (event.target === this.modalTarget) {
      this.hideDeleteModal(event)
    }
  }
}