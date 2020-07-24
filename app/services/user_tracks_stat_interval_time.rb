class UserTracksStatIntervalTime
  def initialize(user, interval)
    @user = user
    @interval = interval
  end

  def call
    search_plock_time_by_interval_time(@user.id, @interval)
  end

  def search_plock_time_by_interval_time(user_id, interval)
    Interval.__elasticsearch__.search({
      query: {
        match: { user_id: user_id }
      },
      aggs: {
        simpleDatehHistogram: {
          date_histogram: {
            field: 'start_at',
            interval: interval
          },
          aggs: {
            time_worked: {
              sum: { field: 'minutes' }
            }
          }
        }
      }
    }).response['aggregations']['simpleDatehHistogram']['buckets']
  end
end
