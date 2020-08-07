require 'test_helper'

class TeamTest < ActiveSupport::TestCase

  test "create team" do
    t  = Team.create(name: "team test")
    assert t.valid?
  end

  test "create team presence name" do
    t  = Team.new
    assert_not t.save
  end

  test "create team name minimun lenght 3" do
    t  = Team.new(name: "te")
    assert_not t.save
  end
end
