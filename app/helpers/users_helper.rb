module UsersHelper
  def interval_types
    ['day', 'week', 'month', 'year']
  end

  def options_for_interval_types
    options_for_select(interval_types, { class: 'form-control', include_blank: true,  multiple: true })
  end
end
