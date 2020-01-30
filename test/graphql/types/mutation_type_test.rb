# frozen_string_literal: true

require 'test_helper'

# class MutationTypeTest extend ActiveSupport::TestCase
#
class MutationTypeTest < ActiveSupport::TestCase
	def setup
		@track = tracks(:one)
		@user = users(:one)
		@interval = intervals(:one)
	end

	test 'interval start' do
		query_string = <<-GRAPHQL
		mutation trackSetIntervalStart($track_id: Int!, $user_id: Int!) {
			intervalStart(trackId: $track_id, userId: $user_id) {
				track {
					name
				}
				startAt
				endAt
			}
		}
		GRAPHQL
		
		track_id = @track.id
		result = PlockSchema.execute(
		query_string,
			variables: { track_id: track_id, user_id: @user.id },
			context: {}
		)
		track_name = result['data']['intervalStart']['track']['name']
		interval_start_at = result['data']['intervalStart']['startAt']
		interval_end_at = result['data']['intervalStart']['endAt']


		assert_not_nil result
		assert_equal(@track.name, track_name)
		assert_equal(interval_start_at, interval_end_at)
	end

	test 'interval end' do
		interval_id = @interval.id
		query_string = <<-GRAPHQL
		mutation trackSetIntervalEnd($id: Int!) {
			intervalEnd(id: $id){
				id
				startAt
				endAt
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

		interval_start_at = result['data']['intervalEnd']['startAt']
		interval_end_at = result['data']['intervalEnd']['endAt']
		assert_not_nil result
		assert_not_equal(interval_start_at, interval_end_at)
	end

	test 'interval destroy' do
		interval_id = @interval.id
		query_string = <<-GRAPHQL
		mutation intervalDestroy($id: Int!) {
			intervalDestroy(id: $id){
				id
				startAt
				endAt
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

		interval_track_name = result['data']['intervalDestroy']['track']['name']
		assert_not_nil result
		assert_equal(@track.name, interval_track_name)
	end
end