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
    Project.create(
      name: 'Is test',
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    p1 = Project.new(
      name: 'Is test',
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    p1.save
    assert_not p1.valid?
  end

  test 'name not null' do
    p = Project.create(
      name: nil,
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    assert_not p.valid?
  end

  test 'repository not null' do
    p = Project.create(
      name: 'Is test',
      repository: nil,
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    assert_not p.valid?
  end

  test 'cost not null' do
    p = Project.create(
      name: 'Is test',
      repository: 'github',
      cost: nil,
      start_at: Date.new,
      user: @user
    )
    assert_not p.valid?
  end

  test 'user_id not null' do
    p = Project.create(
      name: 'Is test',
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: nil
    )
    assert_not p.valid?
  end

  test 'length the name is minimum 5 characters' do
    p = Project.create(
      name: 'test',
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    assert_not p.valid?
<<<<<<< HEAD
  end

  test 'check owner' do
    assert_not_nil (@project.user)
  end

  test 'check not exists tasks' do
    assert_empty (@project.tasks)
  end

  test 'check if there are tasks' do
    p =  projects(:two)
    assert_not_empty (p.tasks)
  end

  test 'check not users in the project' do
    p = Project.create(
      name: 'test',
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    assert_empty (p.users)
  end

  test 'create project with team' do
    p = @project1
    p.team = @team
    assert p.valid?
  end

=======
  end

  test 'check owner' do
    assert_not_nil (@project.user)
  end

  # test 'check not exists tasks' do
  #   assert_empty (@project.tasks)
  # end

  test 'check not users in the project' do
    p = Project.create(
      name: 'test',
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    assert_empty (p.users)
  end
>>>>>>> cf0214ece4a928ad94318db906fc6ea2c2a8f689
end 
