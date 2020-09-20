class EmployeesReportPdf < Prawn::Document
  GENERAL_REPORT = 'general'.freeze 
  INTERVAL_TIME = ['week', 'month', 'year'].freeze

  def initialize(params)
    super()
    @company = params[:company]
    @type = params[:type]
    @years = (@company.created_at.year..DateTime.current.year).to_a.reverse
    @employees = @company.users
    pages
  end

  def pages
    @years.each do |year|
      @year = year
      draw
      start_new_page if year != @years.last
    end
  end

  def draw
    text "#{I18n.t('pdf.year')}: #{@year}", :align => :right, :size => 13
    box_text
    box_text_company
    move_down 100
    show_table
  end

  def box_text
    float do
      move_down 10
      text "#{I18n.t('pdf.report_to_employees')}", :align => :center, :style => :bold
    end
    move_down 30
  end

  def box_text_company
    float do
      move_down 10
      bounding_box([5, cursor], :width => bounds.right - 10) do
        # image @company.logo.url, :width => 100, :height => 100, :align => :right if @company.logo.url.present?
        move_down 10
        indent(10) do
          size_name = @company.name.length > 55 ? 10 : 12
          text "<b>#{I18n.t('pdf.company')}</b>: #{@company.name}", :margin => [20, 100], :inline_format => true, :size => size_name
          text "<b>#{I18n.t('pdf.description')}</b>: #{@company.description}", :inline_format => true, :size => size_name
          text "<b>#{I18n.t('pdf.email')}</b>: #{@company.email}", :inline_format => true, :size => size_name
        end
        move_down 5
        stroke_bounds
      end
    end
  end

  def show_table
    indent(5) do
      table table_data, width: bounds.right - 5 do
        row(0..1).font_style = :bold
        columns(0..4).align = :center
        self.row_colors = ["DDDDDD","FFFFFF"]
        row(0..1).row_colors = ["red"]
        self.header = 2
      end
    end
  end

  def set_name_column_header
    @type == GENERAL_REPORT ? "#{I18n.t('pdf.average')}" : "#{I18n.t('pdf.date')}"
  end

  def table_header
    [
      "#{I18n.t('pdf.email_')}",
      "#{I18n.t('pdf.lastname')}",
      "#{I18n.t('pdf.name')}",
      set_name_column_header,
      "#{I18n.t('pdf.total')}"
    ]
  end

  def set_colspan
    @type == GENERAL_REPORT ? [3, 2] : [4, 1]
  end

  def table_header_text
    [
      {content: "#{I18n.t('pdf.employee')}", colspan: set_colspan.first},
      {content: "#{I18n.t('pdf.hours')}", colspan: set_colspan.second}
    ]
  end

  def table_rows_with_average
    start_at = DateTime.new(@year, 1, 1).strftime('%F')
    end_at = DateTime.new(@year, 12, 31).strftime('%F')
    @employees.order("lastname ASC").map do |user|
      time = Elasticsearch::DataStatistics.new(
        { 
          user_id: user.id,
          company_id: user.company_id,
          start_at: { from_at: start_at, to_at: end_at },
          end_at: { from_at: start_at, to_at: end_at }
        }
      ).minutes_total['time_worked']['value']
      ["#{user.email}", "#{user.lastname}", "#{user.name}", average_general(user, time), hours(time)]
    end
  end

  def table_rows_with_date
    rows = []
    start_at = DateTime.new(@year, 1, 1).strftime('%F')
    end_at = DateTime.new(@year, 12, 31).strftime('%F')
    @employees.order("lastname ASC").each do |user|
      data = Elasticsearch::DataStatistics.new(
        {
          user_id: user.id,
          company_id: user.company_id,
          start_at: { from_at: start_at, to_at: end_at },
          end_at: { from_at: start_at, to_at: end_at }
        }
      ).minutes_by_calendar_interval(@type)
      data.each do |i|
        rows << [
          "#{user.email}",
          "#{user.lastname}",
          "#{user.name}",
          parse(i['key_as_string']),
          hours(i['time_worked']['value'])
        ]
      end
    end
    rows
  end

  def parse(date)
    date_time = Time.parse(date)
    date_time.strftime('%F')
  end

  def table_rows
    @type == GENERAL_REPORT ? table_rows_with_average : table_rows_with_date
  end

  def table_data
    [table_header_text] + [table_header, *table_rows]
  end

  def hours(time)
    time = time / 60
    time.round(2)
  end

  def is_weekend?(day)
    day.saturday? || day.sunday?
  end

  def average_general(user, time)
    total_week = 0
    (user.created_at.to_date..user.updated_at.to_date).each { |day| total_week += 1 if !is_weekend?(day) }
    total_week == 0 ? 0.0 : (hours(time) / total_week).round(2)
  end
end
