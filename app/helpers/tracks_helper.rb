module TracksHelper
  def name_card(type)
    case type
      when 'unstarted'
        t('unstarted')
      when 'in_progress'
        t('in_progress')
      when 'finished'
        t('finished')
    end
  end

  def icon_header(type)
    case type
      when 'unstarted'
        content_tag(:i, nil, :class => "fas fa-circle text-danger")
      when 'in_progress'
        content_tag(:i, nil, :class =>"fas fa-circle text-warning")
      when 'finished'
        content_tag(:i, nil, :class =>"fas fa-check text-success")
    end
  end

  def color_border(type)
    case type
      when 'unstarted'
        'danger'
      when 'in_progress'
        'warning'
      when 'finished'
        'success'
    end
  end
end
