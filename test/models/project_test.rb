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
end
