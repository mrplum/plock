# frozen_string_literal: true
require 'test_helper'

# ProjectsControllerTest class
#
class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = projects(:one)
    @user = users(:matias)
    sign_in @user
  end

  test 'should get index' do
    get projects_url
    assert_response :success
  end

  test 'should get new' do
    get new_project_url
    assert_response :success
  end

  test 'should create project' do
    Project.destroy_all
    assert_difference('Project.count') do
      post projects_url, params: {
        project: {
          cost: @project.cost,
          name: @project.name,
          description: @project.description,
          start_at: @project.start_at
          }
        }
    end

    assert_redirected_to project_url(Project.last)
  end

  test 'should show project' do
    get project_url(@project)
    assert_response :success
  end

  test 'should get edit' do
    get edit_project_url(@project)
    assert_response :success
  end

  test 'should update project' do
    patch project_url(@project), params: {
      project: {
        cost: @project.cost,
        name: @project.name,
        description: @project.description,
        start_at: @project.start_at
      }
    }
    assert_redirected_to project_url(@project)
  end

  test 'should destroy project' do
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end
end
