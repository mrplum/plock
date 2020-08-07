module ConvertToHours
  extend ActiveSupport::Concern
  included do
    def convert_to_hours(time)
      time > 0.0 ? (time / 60.0).round(2) : 0.0
    end
  end
end
