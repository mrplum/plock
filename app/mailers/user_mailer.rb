class UserMailer < ApplicationMailer
  default from: ENV["EMAIL_SENDER"]

  def welcome_email(user, team)
    @user = user
    @team = team
    mail(
      to: user.email,
      subject: ' They have invited you to join the ' + team.name + ' team through Plock'
    )
  end

  def welcome_to_company(company, user)
    @company = company
    @user = user
    mail(
      to: user.email,
      subject: ' They have invited you to join the ' + company.name + ' through Plock'
    )
  end

end
