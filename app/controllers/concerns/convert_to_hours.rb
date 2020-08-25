module ConvertToHours
  extend ActiveSupport::Concern
  included do
    def to_hours(time)
      time / 60.0
    end
  end
end
