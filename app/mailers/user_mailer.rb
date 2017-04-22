class UserMailer < ApplicationMailer
  def new_user(user)
    @user = user
    mail(
      to: user.email,
      subject: "Success"
    )
  end

  def new_message(user)
    @user = user
    mail(
      to: user.email,
      subject: "New message from "
    )
  end
end