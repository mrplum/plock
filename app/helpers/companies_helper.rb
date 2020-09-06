module CompaniesHelper
  def options_for_reports
    [
      ["#{I18n.t('pdf.types.general')}", 'general'],
      ["#{I18n.t('pdf.types.week')}", 'week'],
      ["#{I18n.t('pdf.types.month')}", 'month'],
      ["#{I18n.t('pdf.types.year')}", 'year']
    ]
  end
end
