class Interval < ApplicationRecord
  belongs_to :track
  belongs_to :user
  
  validate :no_other_open_interval

  def open?
    created_at == updated_at
  end

  def no_other_open_interval
    if track.has_open_intervals?
      errors.add :base, 'There is already an open interval, please close before starting a new one'
    end
  end
end