class ActivationMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Dax Records! Please activate your account")
  end
end
