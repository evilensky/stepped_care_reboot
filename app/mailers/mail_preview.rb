# Uses the mail_view gem's MailView class to provide a preview of emails.
class MailPreview < MailView
  def new_for_coach
    coach = User.first
    MessageNotifications.new_for_coach coach
  end
end
