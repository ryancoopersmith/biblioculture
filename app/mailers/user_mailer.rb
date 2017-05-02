class UserMailer < ApplicationMailer
  def new_user(user)
    @user = user
    mail(
      to: user.email,
      subject: "Success"
    )
  end

  def new_message(to, from, message)
    @to = to
    @from = from
    @message = message
    mail(
      to: to.email,
      subject: "New message from #{from.username}"
    )
  end
end
