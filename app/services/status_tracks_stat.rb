class StatusTracksStat
  def initialize(user)
    @user = user
  end

  def call
    Track.where(user_id: @user.id).select("status, count(id) as value").group(:status)
  end

  private

  def search_by_status(user_id)
    Track.__elasticsearch__.search({
      query: {
        match: {
          user_id: user_id
        } 
      },
      aggs: {
        group_by_status: {
          terms: {
            field: 'status.keyword'
          }
        }
      }
    }).response['aggregations']['group_by_status']['buckets']
  end
end
