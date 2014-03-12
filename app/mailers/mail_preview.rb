class MailPreview < MailView
  def new_for_coach
    coach = User.first
    MessageNotifications.new_for_coach coach
  end
end
