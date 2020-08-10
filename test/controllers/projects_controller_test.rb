# frozen_string_literal: true
require 'test_helper'

# ProjectsControllerTest class
#
class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = projects(:one)
    @user = users(:matias)
    @area = areas(:one)
    sign_in @user
  end

  test 'should get index' do
    get projects_url(locale: 'en')
    assert_response :success
  end

  test 'should get new' do
    get new_project_url(locale: 'en')
    assert_response :success
  end

  test 'should create project' do
  post projects_url(locale: 'en'), params: {
    project: {
        cost: 24,
        name: 'name1',
        repository: 'repository1',
        start_at: Time.now,
        user_id: @user.id,
        area_id: @area.id
      }
    }

    assert_response :success
  end

  test 'should show project' do
    get project_url(@project, locale: 'en')
    assert_response :success
  end

  test 'should get edit' do
    get edit_project_url(@project, locale: 'en')
    assert_response :success
  end

  test 'should update project' do
    patch project_url(@project, locale: 'en'), params: {
      project: {
        cost: @project.cost,
        name: @project.name,
        description: @project.description,
        start_at: @project.start_at
      }
    }
    assert_redirected_to project_url(@project, locale: 'en')
  end

  test 'should destroy project' do
    assert_difference('Project.count', -1) do
      delete project_url(@project, locale: 'en')
    end

    assert_redirected_to projects_url(locale: 'en')
  end
end
