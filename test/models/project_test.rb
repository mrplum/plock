# frozen_string_literal: true

require 'test_helper'

# ProjectTest class
#
class ProjectTest < ActiveSupport::TestCase
  def setup
    @user = users(:matias)
  end

  test 'create project' do
    p = Project.new(
      name: 'Is test',
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    p.save
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
  end

  test 'there are no users in the project' do
    p = Project.create(
      name: 'test',
      repository: 'github',
      cost: 5,
      start_at: Date.new,
      user: @user
    )
    assert_empty (p.users)
  end
end
