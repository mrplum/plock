require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "create project" do
    p  = Project.new(
      name: "Is test",
      repository: "github",
      cost: 5,
      start_at: Date.new);
    assert p.valid?
  end

  test "name uniqueness" do
    p  = Project.create(
      name: "Is test",
      repository: "github",
      cost: 5,
      start_at: Date.new);
    p1 = Project.new(
      name: "Is test",
      repository: "github",
      cost: 5,
      start_at: Date.new);
    assert !p1.valid?
  end

  test "name not null" do 
    p  = Project.create(
      name: nil,
      repository: "github",
      cost: 5,
      start_at: Date.new);
    assert !p.valid?
  end

  test "repository not null" do 
    p  = Project.create(
      name: "Is test",
      repository: nil,
      cost: 5,
      start_at: Date.new);
    assert !p.valid?
  end

  test "cost not null" do 
    p  = Project.create(
      name: "Is test",
      repository: "github",
      cost: nil,
      start_at: Date.new);
    assert !p.valid?
  end

  test "length the name is minimum 5 characters" do 
    p  = Project.create(
      name: "test",
      repository: "github",
      cost: 5,
      start_at: Date.new);
    assert !p.valid?
  end

end
