class UserMailer < ApplicationMailer
  default from: ENV["EMAIL_SENDER"]

  def welcome_email
    @user = params[:user]
    @team = params[:team]
    @url  = 'http://example.com/login'
    mail(
      to: @user.email,
      subject: ' They have invited you to join the ' + @team.name + ' team through Plock'
    )
  end

  def welcome_to_company
    @company = params[:company]
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(
      to: @user.email,
      subject: ' They have invited you to join the ' + @company.name + ' through Plock'
    )
  end

end
