import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "confirmInput", "deleteButton"]

  connect() {
    console.log("Settings controller connected")
  }

  showDeleteModal(event) {
    event.preventDefault()
    const modal = this.modalTarget
    const modalContent = modal.querySelector('.relative')
    
    // Show modal with fade-in effect
    modal.classList.remove("hidden")
    modal.classList.add("opacity-0")
    modalContent.classList.add("scale-95")
    
    // Force reflow then animate in
    modal.offsetHeight
    modal.classList.remove("opacity-0")
    modal.classList.add("opacity-100", "transition-opacity", "duration-300", "ease-out")
    modalContent.classList.remove("scale-95")
    modalContent.classList.add("scale-100")
    
    // Focus on the confirmation input after animation
    setTimeout(() => {
      this.confirmInputTarget.focus()
    }, 150)
  }

  hideDeleteModal(event) {
    event.preventDefault()
    const modal = this.modalTarget
    const modalContent = modal.querySelector('.relative')
    
    // Fade out animation
    modal.classList.remove("opacity-100")
    modal.classList.add("opacity-0", "transition-opacity", "duration-200", "ease-in")
    modalContent.classList.remove("scale-100")
    modalContent.classList.add("scale-95")
    
    // Hide after animation completes
    setTimeout(() => {
      modal.classList.add("hidden")
      modal.classList.remove("opacity-0", "transition-opacity", "duration-200", "ease-in")
      modalContent.classList.remove("scale-95")
      modalContent.classList.add("scale-100")
      
      // Reset form state
      this.confirmInputTarget.value = ""
      this.deleteButtonTarget.disabled = true
    }, 200)
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