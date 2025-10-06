module SettingsHelper
  def format_member_since(user)
    user.created_at.strftime("%B %Y")
  end

  def format_last_sign_in(user)
    if user.respond_to?(:last_sign_in_at) && user.last_sign_in_at
      user.last_sign_in_at.strftime("%m/%d/%Y")
    else
      "Today"
    end
  end

  def rental_status_badge_class(status)
    case status
    when 'active'
      'bg-green-100 text-green-800'
    when 'returned'
      'bg-blue-100 text-blue-800'
    when 'overdue'
      'bg-red-100 text-red-800'
    when 'cancelled'
      'bg-gray-100 text-gray-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end

  def user_avatar_initial(user)
    user.email.first.upcase
  end
end