# frozen_string_literal: true

require 'test_helper'

# ProjectTest class
#
class ProjectTest < ActiveSupport::TestCase
  def setup
    @user = users(:matias)
    @project = projects(:one)
    @project1 = projects(:two)
    @team = teams(:one)
  end

  test 'create project' do
    p = Project.create(
      name: 'Is test',
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    assert p.valid?
  end

  test 'name uniqueness' do
    p = Project.create(
      name: 'MyString',
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    assert_not p.valid?
  end

  test 'name not null' do
    p = @project
    p.name = nil
    assert_not p.valid?
  end

  test 'repository not null' do
    p = @project
    p.repository = nil
    assert_not p.valid?
  end

  test 'cost not null' do
    p = @project
    p.cost = nil
    assert_not p.valid?
  end

  test 'user_id not null' do
    p = @project
    p.user = nil
    assert_not p.valid?
  end

  test 'check owner' do
    assert_not_nil @project.user
  end

  test 'check not exists tracks' do
    assert_not_empty @project.tracks
  end

  test 'check if there are tracks' do
    p =  projects(:two)
    assert_not_empty p.tracks
  end

  test 'check not users in the project' do
    p = @project
    assert_not_empty p.users
  end

  test 'create project with team' do
    p = @project1
    p.team = @team
    assert p.valid?
  end

end
