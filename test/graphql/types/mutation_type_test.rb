# frozen_string_literal: true

require 'test_helper'

# class MutationTypeTest extend ActiveSupport::TestCase
#
class MutationTypeTest < ActiveSupport::TestCase
	def setup
		@track = tracks(:one)
		@user = users(:one)
		@interval = intervals(:one)
		@project = projects(:one)
		@name = 'testear'
		@description = 'test'
	end

	test 'interval start' do
		query_string = <<-GRAPHQL
		mutation trackSetIntervalStart($track_id: ID!, $user_id: ID!, $start_at: String! ) {
              intervalStart(trackId: $track_id, userId: $user_id, startAt: $start_at) {
				track {
					name
				}
				startAt
				endAt
			}
		}
		GRAPHQL
		
		datetime = DateTime.now
		track_id = @track.id
		result = PlockSchema.execute(
		query_string,
			variables: { track_id: track_id, user_id: @user.id, start_at: datetime.to_s },
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
		mutation trackSetIntervalEnd($id: ID!, $end_at: String!) {
              intervalEnd(id: $id, endAt: $end_at) {
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
			variables: { id: interval_id, end_at: 2.hours.from_now.to_s },
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

	test 'track create' do
		query_string = <<-GRAPHQL
		mutation createTrack($project_id: ID!, $user_id: ID!, $name: String!, $description: String!) {
			trackCreate(projectId: $project_id, userId: $user_id, name: $name, description: $description) {
				name
				description
			}
		}
		GRAPHQL
		
		result = PlockSchema.execute(
		query_string,
			variables: { project_id: @project.id, user_id: @user.id, name: @name, description: @description },
			context: {}
		)
		track_name = result['data']['trackCreate']['name']


		assert_not_nil result
	end
end