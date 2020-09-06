class CompanyMailer < ApplicationMailer
  default from: ENV["EMAIL_SENDER"] || "plock@mailer.com"

  def send_report(company, current_user, type_report, email)
    @company = company
    @user = current_user
    file = EmployeesReportPdf.new({ company: @company, type: type_report }).render

    attachments["#{I18n.t('pdf.send_email.name_file')}"] = file
    mail(to: email, subject: "Envio de reporte") do |format|
      format.html { render "report_mail" }
    end
  end

end
