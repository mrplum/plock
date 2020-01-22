# frozen_string_literal: true

require 'test_helper'

# class MutationTypeTest extend ActiveSupport::TestCase
#
class MutationTypeTest < ActiveSupport::TestCase
	def setup
		@track = tracks(:one)
		@interval = intervals(:one)
	end

	test 'interval start' do
		query_string = <<-GRAPHQL
		mutation trackSetIntervalStart($track_id: ID!) {
			intervalStart(trackId: $track_id) {
				track {
					name
				}
				createdAt
				updatedAt
			}
		}
		GRAPHQL
		
		track_id = @track.id
		result = PlockSchema.execute(
		query_string,
			variables: { track_id: track_id },
			context: {}
		)
		track_name = result['data']['intervalStart']['track']['name']
		interval_created_at = result['data']['intervalStart']['createdAt']
		interval_updated_at = result['data']['intervalStart']['updatedAt']


		assert_not_nil result
		assert_equal(@track.name, track_name)
		assert_equal(interval_created_at, interval_updated_at)
	end

	test 'interval end' do
		interval_id = @interval.id
		query_string = <<-GRAPHQL
		mutation trackSetIntervalEnd($id: Int!) {
			intervalEnd(id: $id){
				id
				createdAt
				updatedAt
				track {
					name
				}
			}
		}
		GRAPHQL
		result = PlockSchema.execute(
			query_string,
			variables: { id: interval_id },
			context: {}
		)

		interval_created_at = result['data']['intervalEnd']['createdAt']
		interval_updated_at = result['data']['intervalEnd']['updatedAt']
		assert_not_nil result
		assert_not_equal(interval_created_at, interval_updated_at)
	end
end