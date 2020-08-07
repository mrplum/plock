# Examples usage
# service = Elasticsearch::DataStatistics.new({'user_id': 4, 'project_id': 1, 'area_id': 1, 'start_at': {from_at: '2020-08-01', to_at:'2020-12-31'}})
# service.filter_intervals
# service.minutes_total
# service.minutes_by_calendar_interval('day')
class Elasticsearch::DataStatistics
  MATCH_PARAMS = ['user_id', 'area_id', 'company_id', 'track_id', 'project_id', 'team_id'].freeze
  BETWEEN_PARAMS = ['start_at', 'end_at'].freeze
  FORMAT_DATE = "yyyy-MM-dd".freeze

  def initialize(params)
    @params = params
  end

  def filter_intervals
    begin
      Interval.__elasticsearch__.search(filter_data).response['hits']['hits']
    rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e 
      parse_error(e.message)
    end
  end

  def minutes_total
    begin
      Interval.__elasticsearch__.search(
        filter_data.merge(sum_minutes)
      ).response['aggregations']
    rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e 
      parse_error(e.message)
    end
  end

  def minutes_by_calendar_interval(interval)
    begin
      Interval.__elasticsearch__.search(
        filter_data.merge(sum_grouped_calendar_interval(interval))
      ).response['aggregations']['sales_over_time']['buckets']
      rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e 
        parse_error(e.message)
    end
  end

  private

  def match_query
    match_params = [ ]
    @params.each do |key, value|
      match_params << { match: { key => value } } if MATCH_PARAMS.include?(key.to_s)
    end
    match_params
  end

  def between_dates
    ranges = []
    @params.each. each do |key, value|
      ranges << {
        range: {
          "#{key}": {
            format: FORMAT_DATE,
            gte: "#{value[:from_at]}",
            lte: "#{value[:to_at]}", 
          }
        }
      } if BETWEEN_PARAMS.include?(key.to_s) && value.length == 2
    end
    ranges
  end

  def filter
    {
      filter: match_query,
      must: between_dates
    }
  end


  def filter_data
    {
      query: {
        bool: filter
      }
    }
  end

  def sum_minutes
    {
      aggs: {
        time_worked: {
          sum: { field: "minutes" }
        }
      }
    }
  end

  def sum_grouped_calendar_interval(interval)
    {
      aggs: {
        sales_over_time: {
          date_histogram: {
            field: "start_at",
            calendar_interval: interval
          }
        }.merge(sum_minutes)
      }
    }
  end

  def parse_error(message)
    JSON.parse(message.gsub('[400] ', ''))
  end
end
