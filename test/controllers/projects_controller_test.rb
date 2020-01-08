# frozen_string_literal: true
require 'test_helper'

# ProjectTest class
#
class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = projects(:one)
    @user = users(:one)
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

  # test 'should create project' do
  #   Project.destroy_all
  #   params = {
  #     project:{
  #       cost: @project.cost,
  #       name: @project.name,
  #       repository: @project.repository,
  #       start_at: @project.start_at,
  #       user_id: current_user.id
  #     }
  #   }
  #     post projects_url(params)
  #   assert_redirected_to project_url(Project.last)
  # end

  test 'should show project' do
    get project_url(@project)
    assert_response :success
  end

  test 'should get edit' do
    get edit_project_url(@project)
    assert_response :success
  end

  # test 'should update project' do
  #   patch project_url(@project), params: { project: { cost: @project.cost, name: @project.name, repository: @project.repository, start_at: @project.start_at } }
  #   assert_redirected_to project_url(@project)
  # end

  test 'should destroy project' do
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end
end
