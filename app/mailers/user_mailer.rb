class UserMailer < ApplicationMailer
  def message_to_user(address, message)
    @message = message
    mail to: address, subject: t('.admin_message')
  end
end