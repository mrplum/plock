class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def welcome_email
    @user = params[:user]
    @team = params[:team]
    @url  = 'http://example.com/login'
    mail(
      to: @user.email,
      subject: ' They have invited you to join the ' + @team.name + ' team through Plock'
    )
  end
end
