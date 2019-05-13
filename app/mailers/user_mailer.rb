class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
=begin  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end

=end

=begin
  def forgot_password(user)
  @user = user
  @greeting = "Hi"

  mail to: user.email, :subject => 'Reset password instructions'
end
=end

def forgot_password(user)
  @user = user
  @greeting = "Hi"

  mail to: user.email, :subject => 'Reset password instructions'
end

end
