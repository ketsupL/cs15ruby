import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "confirmInput", "deleteButton"]

  connect() {
    console.log("Settings controller connected")
  }

  showDeleteModal(event) {
    event.preventDefault()
    this.modalTarget.classList.remove("hidden")
    // Focus on the confirmation input
    setTimeout(() => {
      this.confirmInputTarget.focus()
    }, 100)
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
    const button = event.target
    button.textContent = "Deleting Account..."
    button.disabled = true
    
    return true
  }

  // Close modal when clicking outside
  modalClicked(event) {
    if (event.target === this.modalTarget) {
      this.hideDeleteModal(event)
    }
  }
}